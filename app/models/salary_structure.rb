class SalaryStructure < ApplicationRecord
  belongs_to :user

  validates :base_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :housing_allowance, :transport_allowance, :medical_allowance,
            :tax_deduction, :provident_fund_deduction, numericality: { greater_than_or_equal_to: 0 }

  def total_allowances
    (housing_allowance || 0) + (transport_allowance || 0) + (medical_allowance || 0)
  end

  def total_deductions
    (tax_deduction || 0) + (provident_fund_deduction || 0)
  end

  def gross_salary
    (base_salary || 0) + total_allowances
  end

  def net_salary
    gross_salary - total_deductions
  end
end
