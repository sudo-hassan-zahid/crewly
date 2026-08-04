module Subscriptions
  class GatekeeperService
    TIER_PERMISSIONS = {
      starter: [:core_hr, :attendance, :leaves],
      growth: [:core_hr, :attendance, :leaves, :payroll, :documents],
      enterprise: [:core_hr, :attendance, :leaves, :payroll, :documents, :activity_tracker, :analytics, :custom_branding]
    }.freeze

    def self.feature_enabled?(organization, feature)
      tier = organization&.plan&.to_sym || :starter
      allowed_features = TIER_PERMISSIONS[tier] || TIER_PERMISSIONS[:starter]
      allowed_features.include?(feature.to_sym)
    end
  end
end
