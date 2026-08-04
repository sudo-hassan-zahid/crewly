class Notification < ApplicationRecord
  belongs_to :user

  enum notification_type: { info: 0, success: 1, warning: 2, alert: 3 }

  validates :title, :message, presence: true

  scope :unread, -> { where(read: false) }
end
