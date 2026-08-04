module Payroll
  class TaxCalculatorService
    def self.calculate(annual_gross_income)
      new(annual_gross_income).compute
    end

    def initialize(annual_gross_income)
      @annual_gross = annual_gross_income
    end

    def compute
      tds = calculate_income_tax(@annual_gross)
      pf = (@annual_gross * 0.05).round(2)
      esi = @annual_gross < 250000 ? (@annual_gross * 0.0075).round(2) : 0.0

      {
        annual_tax: tds,
        monthly_tds: (tds / 12).round(2),
        provident_fund: pf,
        esi_contribution: esi,
        total_deductions: tds + pf + esi
      }
    end

    private

    def calculate_income_tax(income)
      tax = 0.0
      return tax if income <= 300000

      if income > 300000 && income <= 600000
        tax += (income - 300000) * 0.05
      elsif income > 600000 && income <= 900000
        tax += 15000 + (income - 600000) * 0.10
      elsif income > 900000 && income <= 1200000
        tax += 45000 + (income - 900000) * 0.15
      else
        tax += 90000 + (income - 1200000) * 0.20
      end

      tax.round(2)
    end
  end
end
