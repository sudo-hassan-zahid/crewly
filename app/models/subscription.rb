class Subscription < ApplicationRecord
  belongs_to :organization

  enum plan_tier: { starter: 0, growth: 1, enterprise: 2 }
  enum status: { active: 0, past_due: 1, canceled: 2 }

  validates :plan_tier, :status, presence: true
end
