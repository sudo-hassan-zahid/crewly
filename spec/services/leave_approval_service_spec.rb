require "rails_helper"

RSpec.describe Leaves::LeaveApprovalService do
  describe ".approve" do
    let(:user) { User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", employee_number: "EMP001") }
    let(:manager) { User.create!(first_name: "Jane", last_name: "Smith", email: "jane@example.com", password: "password", employee_number: "EMP002", role: :manager) }
    let(:leave_type) { LeaveType.create!(name: "Annual Leave", code: "AL", default_days_per_year: 20) }
    let(:leave_request) { LeaveRequest.create!(user: user, leave_type: leave_type, start_date: Date.today, end_date: Date.today + 2.days, reason: "Vacation") }

    it "approves a pending leave request and marks attendance records" do
      result = Leaves::LeaveApprovalService.approve(leave_request, manager)
      expect(result[:success]).to be true
      expect(leave_request.reload.status).to eq("approved")
      expect(leave_request.approved_by).to eq(manager)
    end
  end
end
