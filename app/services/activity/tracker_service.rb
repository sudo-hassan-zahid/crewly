module Activity
  class TrackerService
    def self.ingest(user, payload)
      new(user, payload).process
    end

    def initialize(user, payload)
      @user = user
      @payload = payload
    end

    def process
      log = ActivityLog.create!(
        user: @user,
        keystrokes_count: @payload[:keystrokes_count] || 0,
        mouse_clicks_count: @payload[:mouse_clicks_count] || 0,
        active_window_title: @payload[:active_window_title],
        screenshot_url: @payload[:screenshot_url],
        logged_at: @payload[:logged_at] || Time.current
      )

      # Real-time WebSocket broadcast via ActionCable
      broadcast_payload = {
        user_id: @user.id,
        user_name: @user.full_name,
        keystrokes_count: log.keystrokes_count,
        mouse_clicks_count: log.mouse_clicks_count,
        active_window_title: log.active_window_title,
        screenshot_url: log.screenshot_url,
        productivity_score: log.productivity_score,
        logged_at: log.logged_at.iso8601
      }

      ActionCable.server.broadcast("activity_channel", broadcast_payload)
      ActionCable.server.broadcast("activity_user_#{@user.id}", broadcast_payload)

      LoggerService.info(
        component: "ActivityTracker",
        event: "INGEST",
        message: "Ingested activity batch for user #{@user.id}",
        payload: broadcast_payload
      )

      { success: true, log: log }
    rescue StandardError => e
      LoggerService.error(component: "ActivityTracker", event: "ERROR", message: e.message, exception: e)
      { success: false, error: e.message }
    end
  end
end
