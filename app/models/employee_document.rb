class EmployeeDocument < ApplicationRecord
  belongs_to :user

  enum document_type: { identity_proof: 0, passport: 1, contract: 2, certificate: 3, other: 4 }

  validates :title, presence: true
end
