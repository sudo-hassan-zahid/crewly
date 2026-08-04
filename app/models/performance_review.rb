class PerformanceReview < ApplicationRecord
  belongs_to :user
  belongs_to :reviewer, class_name: "User"

  enum status: { draft: 0, submitted: 1, completed: 2 }

  validates :review_period, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
