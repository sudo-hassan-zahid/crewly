class AttendanceRecord < ApplicationRecord
  belongs_to :user

  enum status: { present: 0, late: 1, half_day: 2, absent: 3, on_leave: 4 }

  validates :date, presence: true
  validates :user_id, uniqueness: { scope: :date, message: "already has an attendance record for this date" }

  before_save :calculate_hours

  private

  def calculate_hours
    return unless clock_in.present? && clock_out.present?

    self.total_hours = ((clock_out - clock_in) / 1.hour).round(2)
  end
end
