require "csv"

module Reports
  class AttendanceExportService
    def self.call(month = Date.today.month, year = Date.today.year)
      new(month, year).generate_csv
    end

    def initialize(month, year)
      @month = month
      @year = year
      @start_date = Date.new(year, month, 1)
      @end_date = @start_date.end_of_month
    end

    def generate_csv
      headers = ["Employee Number", "Employee Name", "Department", "Date", "Clock In", "Clock Out", "Total Hours", "Status", "Notes"]
      
      CSV.generate(headers: true) do |csv|
        csv << headers
        
        AttendanceRecord.includes(user: :department)
                        .where(date: @start_date..@end_date)
                        .find_each do |record|
          csv << [
            record.user.employee_number,
            record.user.full_name,
            record.user.department&.name || "N/A",
            record.date.to_s,
            record.clock_in&.strftime("%H:%M:%S"),
            record.clock_out&.strftime("%H:%M:%S"),
            record.total_hours,
            record.status.titleize,
            record.notes
          ]
        end
      end
    end
  end
end
