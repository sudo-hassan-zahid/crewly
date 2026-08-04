module Api
  module V1
    class LeaveRequestsController < BaseController
      before_action :set_leave_request, only: [:show, :approve, :reject]

      def index
        requests = LeaveRequest.includes(:user, :leave_type).order(created_at: :desc)
        render_success(data: requests.as_json(include: [:user, :leave_type]))
      end

      def show
        render_success(data: @leave_request.as_json(include: [:user, :leave_type]))
      end

      def create
        request = LeaveRequest.new(leave_request_params)
        if request.save
          LoggerService.info(component: "LeaveAPI", event: "APPLY", message: "User #{request.user_id} requested leave")
          render_success(data: request, status: :created)
        else
          render_error(errors: request.errors.full_messages)
        end
      end

      def approve
        manager = User.find(params[:manager_id])
        result = Leaves::LeaveApprovalService.approve(@leave_request, manager)
        if result[:success]
          LoggerService.audit(user: manager, action: "APPROVE_LEAVE", target: "LeaveRequest##{@leave_request.id}")
          render_success(data: result[:leave_request], message: "Leave approved")
        else
          render_error(errors: result[:error])
        end
      end

      def reject
        manager = User.find(params[:manager_id])
        result = Leaves::LeaveApprovalService.reject(@leave_request, manager, params[:reason])
        if result[:success]
          LoggerService.audit(user: manager, action: "REJECT_LEAVE", target: "LeaveRequest##{@leave_request.id}")
          render_success(data: result[:leave_request], message: "Leave rejected")
        else
          render_error(errors: result[:error])
        end
      end

      private

      def set_leave_request
        @leave_request = LeaveRequest.find(params[:id])
      end

      def leave_request_params
        params.require(:leave_request).permit(:user_id, :leave_type_id, :start_date, :end_date, :reason)
      end
    end
  end
end
