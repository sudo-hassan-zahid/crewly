module Leaves
  class AccrualEngineService
    def self.process_monthly_accrual
      LoggerService.info(component: "LeaveAccrual", event: "START", message: "Processing monthly leave accruals")
      processed = 0

      User.active.find_each do |user|
        LeaveType.all.each do |leave_type|
          monthly_rate = (leave_type.default_days_per_year.to_f / 12).round(2)
          # Log monthly accrual increment
          LoggerService.info(
            component: "LeaveAccrual",
            event: "ACCRUED",
            message: "Accrued #{monthly_rate} days of #{leave_type.name} for user #{user.id}"
          )
          processed += 1
        end
      end

      { success: true, processed_accruals: processed }
    end
  end
end
