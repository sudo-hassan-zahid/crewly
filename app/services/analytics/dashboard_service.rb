module Analytics
  class DashboardService
    def self.generate_stats
      total_employees = User.active.count
      total_departments = Department.active.count
      today_present = AttendanceRecord.where(date: Date.today, status: [:present, :late]).count
      today_absent = AttendanceRecord.where(date: Date.today, status: :absent).count
      pending_leaves = LeaveRequest.pending.count
      avg_productivity = ActivityLog.where("logged_at >= ?", 24.hours.ago).average(:productivity_score)&.round(2) || 0.0

      {
        total_employees: total_employees,
        total_departments: total_departments,
        attendance_today: {
          present: today_present,
          absent: today_absent,
          attendance_rate: total_employees.positive? ? ((today_present.to_f / total_employees) * 100).round(1) : 0.0
        },
        pending_leaves_count: pending_leaves,
        average_productivity_score_24h: avg_productivity
      }
    end
  end
end
