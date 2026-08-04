class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_user_#{params[:user_id]}" if params[:user_id].present?
  end

  def unsubscribed
    # Cleanup when unsubscribed
  end
end
