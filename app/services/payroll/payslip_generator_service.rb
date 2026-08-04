module Payroll
  class PayslipGeneratorService
    def self.call(user, month, year)
      new(user, month, year).perform
    end

    def initialize(user, month, year)
      @user = user
      @month = month
      @year = year
    end

    def perform
      salary_structure = @user.salary_structure
      return { success: false, error: "No active salary structure found for employee" } unless salary_structure

      existing_payslip = Payslip.find_by(user: @user, month: @month, year: @year)
      return { success: false, error: "Payslip already exists for this period" } if existing_payslip

      payslip = Payslip.create!(
        user: @user,
        month: @month,
        year: @year,
        gross_salary: salary_structure.gross_salary,
        total_allowances: salary_structure.total_allowances,
        total_deductions: salary_structure.total_deductions,
        net_salary: salary_structure.net_salary,
        status: :generated
      )

      { success: true, payslip: payslip }
    rescue StandardError => e
      { success: false, error: e.message }
    end
  end
end
