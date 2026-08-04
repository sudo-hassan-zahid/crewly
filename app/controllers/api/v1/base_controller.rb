module Api
  module V1
    class BaseController < ActionController::API
      include Pundit::Authorization

      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized
      rescue_from ActionController::ParameterMissing, with: :render_bad_request

      private

      def render_success(data: {}, message: "Success", status: :ok)
        render json: { success: true, message: message, data: data }, status: status
      end

      def render_error(errors:, status: :unprocessable_entity)
        render json: { success: false, errors: Array(errors) }, status: status
      end

      def render_not_found(exception)
        render json: { success: false, error: exception.message || "Resource not found" }, status: :not_found
      end

      def render_unauthorized
        render json: { success: false, error: "You are not authorized to perform this action" }, status: :forbidden
      end

      def render_bad_request(exception)
        render json: { success: false, error: exception.message }, status: :bad_request
      end
    end
  end
end
