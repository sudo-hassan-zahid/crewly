class Department < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :designations, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }

  scope :active, -> { where(active: true) }
end
