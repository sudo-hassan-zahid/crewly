module Payroll
  class BatchProcessingJob < ActiveJob::Base
    queue_as :default

    def perform(month = Date.today.month, year = Date.today.year)
      LoggerService.info(component: "BatchPayrollJob", event: "START", message: "Starting monthly payroll batch for #{month}/#{year}")
      processed_count = 0
      error_count = 0

      User.active.find_each do |employee|
        next unless employee.salary_structure.present?

        result = Payroll::PayslipGeneratorService.call(employee, month, year)
        if result[:success]
          processed_count += 1
        else
          error_count += 1
          LoggerService.warn(component: "BatchPayrollJob", event: "SKIP", message: "Skipped user #{employee.id}: #{result[:error]}")
        end
      end

      LoggerService.info(
        component: "BatchPayrollJob",
        event: "COMPLETE",
        message: "Completed monthly payroll batch for #{month}/#{year}",
        payload: { processed_count: processed_count, error_count: error_count }
      )
    end
  end
end
