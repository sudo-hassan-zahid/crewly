module Api
  module V1
    class AnalyticsController < BaseController
      def dashboard
        stats = Analytics::DashboardService.generate_stats
        render_success(data: stats, message: "HR Analytics generated successfully")
      end
    end
  end
end
