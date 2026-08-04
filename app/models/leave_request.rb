class LeaveRequest < ApplicationRecord
  belongs_to :user
  belongs_to :leave_type
  belongs_to :approved_by, class_name: "User", optional: true

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  before_validation :set_total_days

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def set_total_days
    return if start_date.blank? || end_date.blank?

    self.total_days = (end_date - start_date).to_i + 1
  end
end
