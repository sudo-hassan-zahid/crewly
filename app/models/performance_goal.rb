class PerformanceGoal < ApplicationRecord
  belongs_to :user

  enum status: { not_started: 0, in_progress: 1, completed: 2, cancelled: 3 }

  validates :title, presence: true
  validates :progress_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
