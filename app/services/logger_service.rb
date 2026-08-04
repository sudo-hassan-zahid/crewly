class LoggerService
  class << self
    def info(component:, event:, message:, payload: {})
      log(:info, component: component, event: event, message: message, payload: payload)
    end

    def warn(component:, event:, message:, payload: {})
      log(:warn, component: component, event: event, message: message, payload: payload)
    end

    def error(component:, event:, message:, payload: {}, exception: nil)
      payload[:exception_class] = exception.class.name if exception
      payload[:exception_message] = exception.message if exception
      payload[:backtrace] = exception.backtrace&.first(5) if exception

      log(:error, component: component, event: event, message: message, payload: payload)
    end

    def audit(user:, action:, target:, details: {})
      log(:info, component: "AuditLog", event: action, message: "User #{user&.id || 'system'} performed #{action} on #{target}", payload: details.merge(user_id: user&.id))
    end

    private

    def log(level, component:, event:, message:, payload:)
      log_entry = {
        timestamp: Time.current.iso8601,
        environment: Rails.env,
        level: level.to_s.upcase,
        component: component,
        event: event,
        message: message,
        payload: payload
      }

      if ENV["STRUCTURED_LOGGING"] == "true"
        Rails.logger.send(level, log_entry.to_json)
      else
        formatted_str = "[#{log_entry[:timestamp]}] [#{log_entry[:level]}] [#{component}::#{event}] #{message} | Details: #{payload.to_json}"
        Rails.logger.send(level, formatted_str)
      end
    end
  end
end
