class Payslip < ApplicationRecord
  belongs_to :user

  enum status: { draft: 0, generated: 1, paid: 2 }

  validates :month, presence: true, inclusion: { in: 1..12 }
  validates :year, presence: true, numericality: { greater_than_or_equal_to: 2000 }
  validates :gross_salary, :net_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, uniqueness: { scope: [:month, :year], message: "payslip already generated for this month and year" }

  def period_name
    Date::MONTHNAMES[month] + " #{year}"
  end
end
