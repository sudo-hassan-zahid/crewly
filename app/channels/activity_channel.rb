class ActivityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "activity_channel"
    if params[:user_id].present?
      stream_from "activity_user_#{params[:user_id]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
