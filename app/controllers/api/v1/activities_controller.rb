class Api::V1::ActivitiesController < API::V1::BaseController
  before_action :set_user_id, only: :create

  def index
    activities = current_user.activities.all
    render json: activities
  end

  def create
    activity = current_user.activities.new(activity_params)
    if activity.save!
      success(I18n.t("success_message.#{activity.event_type}_success"))
    else
      bad_request(activity.errors)
    end
  end

  private

  def activity_params
    params.require(:activity).permit!
  end

  def set_user_id
    params[:activity][:user_id] = current_user.id
  end
end