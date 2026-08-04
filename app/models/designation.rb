class Designation < ApplicationRecord
  belongs_to :department, optional: true
  has_many :users, dependent: :nullify

  validates :title, presence: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }
end
