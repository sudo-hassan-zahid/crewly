module Notifications
  class DispatcherService
    def self.send_notification(user:, title:, message:, type: :info, action_url: nil)
      notification = Notification.create!(
        user: user,
        title: title,
        message: message,
        notification_type: type,
        action_url: action_url
      )

      payload = {
        id: notification.id,
        title: notification.title,
        message: notification.message,
        notification_type: notification.notification_type,
        action_url: notification.action_url,
        created_at: notification.created_at.iso8601
      }

      ActionCable.server.broadcast("notification_user_#{user.id}", payload)

      LoggerService.info(
        component: "NotificationDispatcher",
        event: "SEND",
        message: "Dispatched #{type} notification to User ##{user.id}",
        payload: payload
      )

      { success: true, notification: notification }
    rescue StandardError => e
      LoggerService.error(component: "NotificationDispatcher", event: "ERROR", message: e.message, exception: e)
      { success: false, error: e.message }
    end
  end
end
