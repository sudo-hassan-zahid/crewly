class Company < ApplicationRecord
  belongs_to :parent_company, class_name: "Company", optional: true
  has_many :subsidiaries, class_name: "Company", foreign_key: "parent_company_id", dependent: :nullify
  has_many :users, dependent: :nullify

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }
end
