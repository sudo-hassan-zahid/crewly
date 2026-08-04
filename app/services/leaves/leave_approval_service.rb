module Leaves
  class LeaveApprovalService
    def self.approve(leave_request, manager)
      return { success: false, error: "Request is not pending" } unless leave_request.pending?

      ActiveRecord::Base.transaction do
        leave_request.update!(
          status: :approved,
          approved_by: manager
        )

        # Automatically mark attendance as on_leave for dates in range
        (leave_request.start_date..leave_request.end_date).each do |date|
          AttendanceRecord.find_or_create_by!(user: leave_request.user, date: date) do |ar|
            ar.status = :on_leave
            ar.notes = "Approved leave: #{leave_request.leave_type.name}"
          end
        end
      end

      { success: true, leave_request: leave_request }
    rescue StandardError => e
      { success: false, error: e.message }
    end

    def self.reject(leave_request, manager, reason = nil)
      return { success: false, error: "Request is not pending" } unless leave_request.pending?

      leave_request.update!(
        status: :rejected,
        approved_by: manager,
        rejection_reason: reason
      )

      { success: true, leave_request: leave_request }
    end
  end
end
