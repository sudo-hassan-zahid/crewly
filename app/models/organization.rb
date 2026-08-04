class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :designations, dependent: :destroy
  has_many :attendance_records, dependent: :destroy
  has_many :leave_requests, dependent: :destroy
  has_many :payslips, dependent: :destroy

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9\-]+\z/ }

  scope :active, -> { where(active: true) }
end
