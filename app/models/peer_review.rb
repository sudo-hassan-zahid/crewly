class PeerReview < ApplicationRecord
  belongs_to :reviewee, class_name: "User"
  belongs_to :reviewer, class_name: "User"

  validates :relationship, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
