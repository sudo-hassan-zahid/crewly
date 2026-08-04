module Api
  module V1
    class AttendanceRecordsController < BaseController

      def index
        records = AttendanceRecord.includes(:user).order(date: :desc)
        render_success(data: records.as_json(include: { user: { only: [:id, :first_name, :last_name, :employee_number] } }))
      end

      def clock_in
        user = User.find(params[:user_id])
        result = Attendance::ClockInOutService.clock_in(user, params[:notes])
        if result[:success]
          LoggerService.info(component: "AttendanceAPI", event: "CLOCK_IN", message: "User #{user.id} clocked in")
          render_success(data: result[:record], message: "Clocked in successfully")
        else
          render_error(errors: result[:error])
        end
      end

      def clock_out
        user = User.find(params[:user_id])
        result = Attendance::ClockInOutService.clock_out(user)
        if result[:success]
          LoggerService.info(component: "AttendanceAPI", event: "CLOCK_OUT", message: "User #{user.id} clocked out")
          render_success(data: result[:record], message: "Clocked out successfully")
        else
          render_error(errors: result[:error])
        end
      end
    end
  end
end
