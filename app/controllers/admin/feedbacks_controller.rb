class Admin::FeedbacksController < ApplicationController
    before_action :authorize_admin
    def index
      @date = params[:date].present? ? Date.parse(params[:date]) : Date.today 

      @feedbacks = Feedback.joins(:user).where(created_at: @date.all_day)

      @average_dinner_rating = @feedbacks.average(:rating_for_dinner).to_f.round(2) || 0
      @average_snack_rating = @feedbacks.average(:rating_for_snack).to_f.round(2) || 0
    end

    private
    def authorize_admin
      redirect_to root_path, alert: "Access Denied" unless current_user.admin?
    end
end
