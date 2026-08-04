module Payroll
  class BankExportService
    def self.generate_sepa_xml(month = Date.today.month, year = Date.today.year)
      payslips = Payslip.includes(user: :department).where(month: month, year: year, status: :generated)
      
      builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
        xml.Document(xmlns: "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03") do
          xml.CstmrCdtTrfInitn do
            xml.GrpHdr do
              xml.MsgId "PAYROLL-#{year}-#{month}-#{Time.now.to_i}"
              xml.CreDtTm Time.now.iso8601
              xml.NbOfTxs payslips.count
              xml.CtrlSum payslips.sum(:net_salary)
            end
            
            payslips.each do |payslip|
              xml.PmtInf do
                xml.PmtInfId "PAY-#{payslip.id}"
                xml.PmtMtd "TRF"
                xml.Amt { xml.InstdAmt("%.2f" % payslip.net_salary, Ccy: "USD") }
                xml.Cdtr { xml.Nm payslip.user.full_name }
              end
            end
          end
        end
      end
      
      builder.to_xml
    end
  end
end
