module Api
  module V1
    class ActivityLogsController < BaseController
      def index
        logs = ActivityLog.includes(:user).order(logged_at: :desc).limit(100)
        render_success(data: logs.as_json(include: { user: { only: [:id, :first_name, :last_name, :employee_number] } }))
      end

      def ingest
        user = User.find(params[:user_id])
        result = Activity::TrackerService.ingest(user, activity_params)

        if result[:success]
          render_success(data: result[:log], message: "Telemetry ingested and broadcast in real-time", status: :created)
        else
          render_error(errors: result[:error])
        end
      end

      private

      def activity_params
        params.permit(:keystrokes_count, :mouse_clicks_count, :active_window_title, :screenshot_url, :logged_at)
      end
    end
  end
end
