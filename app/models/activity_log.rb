class ActivityLog < ApplicationRecord
  belongs_to :user

  validates :logged_at, presence: true
  validates :keystrokes_count, :mouse_clicks_count, numericality: { greater_than_or_equal_to: 0 }

  before_save :compute_productivity_score

  private

  def compute_productivity_score
    total_interactions = keystrokes_count + (mouse_clicks_count * 2)
    # Scale score out of 100 based on expected interaction density per batch
    self.productivity_score = [ (total_interactions / 3.0).round(2), 100.0 ].min
  end
end
