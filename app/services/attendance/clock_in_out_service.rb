module Attendance
  class ClockInOutService
    def self.clock_in(user, notes = nil)
      today = Date.today
      record = AttendanceRecord.find_or_initialize_by(user: user, date: today)
      return { success: false, error: "Already clocked in today" } if record.clock_in.present?

      record.clock_in = Time.current
      record.notes = notes if notes.present?
      # Mark status: late if clocked in after 09:30 AM
      record.status = record.clock_in.strftime("%H:%M") > "09:30" ? :late : :present

      if record.save
        { success: true, record: record }
      else
        { success: false, error: record.errors.full_messages.join(", ") }
      end
    end

    def self.clock_out(user)
      today = Date.today
      record = AttendanceRecord.find_by(user: user, date: today)
      return { success: false, error: "No clock-in record found for today" } unless record
      return { success: false, error: "Already clocked out today" } if record.clock_out.present?

      record.clock_out = Time.current
      if record.save
        { success: true, record: record }
      else
        { success: false, error: record.errors.full_messages.join(", ") }
      end
    end
  end
end
