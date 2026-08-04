class Shift < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :name, :start_time, :end_time, presence: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }

  scope :active, -> { where(active: true) }
end
