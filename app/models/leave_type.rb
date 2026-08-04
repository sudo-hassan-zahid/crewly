class LeaveType < ApplicationRecord
  has_many :leave_requests, dependent: :restrict_with_error

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :default_days_per_year, numericality: { greater_than_or_equal_to: 0 }
end
