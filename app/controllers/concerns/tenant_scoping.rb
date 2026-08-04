module TenantScoping
  extend ActiveSupport::Concern

  included do
    before_action :set_current_tenant
  end

  private

  def set_current_tenant
    tenant_identifier = request.headers["X-Tenant-ID"] || request.subdomain
    organization = Organization.find_by(subdomain: tenant_identifier) if tenant_identifier.present?
    organization ||= Organization.first

    Current.organization = organization
  end
end
