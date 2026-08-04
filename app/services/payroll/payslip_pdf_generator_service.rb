module Payroll
  class PayslipPdfGeneratorService
    def self.call(payslip)
      new(payslip).generate
    end

    def initialize(payslip)
      @payslip = payslip
      @user = payslip.user
    end

    def generate
      require "prawn"
      require "prawn/table"

      pdf = Prawn::Document.new(page_size: "A4", margin: [40, 40, 40, 40])
      
      # Header
      pdf.text "HRMS ENTERPRISE - PAYSLIP", size: 20, style: :bold, align: :center
      pdf.text "Pay Period: #{@payslip.period_name}", size: 12, align: :center
      pdf.move_down 20

      # Employee Info Table
      employee_info = [
        ["Employee ID:", @user.employee_number, "Department:", @user.department&.name || "N/A"],
        ["Employee Name:", @user.full_name, "Designation:", @user.designation&.title || "N/A"],
        ["Status:", @payslip.status.titleize, "Payment Date:", @payslip.payment_date&.strftime("%B %d, %Y") || "N/A"]
      ]
      pdf.table(employee_info, cell_style: { border_width: 0, padding: 4 })
      pdf.move_down 20

      # Financial Breakdown
      financial_headers = ["Earnings", "Amount ($)", "Deductions", "Amount ($)"]
      financial_data = [
        financial_headers,
        ["Base Salary", "%.2f" % (@payslip.gross_salary - @payslip.total_allowances), "Tax Deduction", "%.2f" % (@payslip.total_deductions * 0.7)],
        ["Allowances", "%.2f" % @payslip.total_allowances, "Provident Fund", "%.2f" % (@payslip.total_deductions * 0.3)],
        ["Gross Earnings", "%.2f" % @payslip.gross_salary, "Total Deductions", "%.2f" % @payslip.total_deductions],
        ["NET SALARY PAYABLE", "%.2f" % @payslip.net_salary, "", ""]
      ]
      
      pdf.table(financial_data, header: true, width: pdf.bounds.width) do
        row(0).font_style = :bold
        row(4).font_style = :bold
      end

      pdf.move_down 40
      pdf.text "This is a computer-generated document and does not require a physical signature.", size: 9, style: :italic, align: :center

      pdf.render
    rescue StandardError => e
      LoggerService.error(component: "PayslipPdfGenerator", event: "PDF_ERROR", message: e.message, exception: e)
      nil
    end
  end
end
