class Employee::FeedbacksController < ApplicationController
  before_action :set_daily_meal_record, only: [:new, :create]
  before_action :check_existing_feedback, only: [:new, :create]

  def new
    return if performed?

    if @daily_meal_record
      @feedback = Feedback.new
      set_feedback_messages
    else
      redirect_to new_employee_daily_meal_record_path, notice: "You are not eligible to provide feedback for #{day_label} meal because you did not select a meal!"
    end
  end

  def create
    return if performed?

    @feedback = current_user.feedbacks.build(feedback_params.merge(daily_meal_record: @daily_meal_record))

    if @feedback.save
      redirect_to new_employee_daily_meal_record_path, notice: "Thank you for your feedback!"
    else
      flash.now[:alert] = @feedback.errors.full_messages.first
      render :new
    end
  end

  private
  
  def set_daily_meal_record
    if Date.today.monday?
      @daily_meal_record = DailyMealRecord.find_by(user_id: current_user.id, date: Date.today - 3)
      @day_label = "Friday"
      
      if @daily_meal_record.nil?
        @daily_meal_record = DailyMealRecord.find_by(user_id: current_user.id, date: Date.today - 4)
        @day_label = "Thursday"
      end
    else
      @daily_meal_record = DailyMealRecord.find_by(user_id: current_user.id, date: Date.yesterday)
      @day_label = "yesterday"
    end
  
    if @daily_meal_record.nil?
      redirect_to new_employee_daily_meal_record_path, alert: "No meal record found for #{@day_label}. Please ensure your meal was logged."
    end
  end
  

  def check_existing_feedback
    existing_feedback = Feedback.find_by(daily_meal_record: @daily_meal_record, user: current_user)
    if existing_feedback.present?
      redirect_to new_employee_daily_meal_record_path, notice: "Feedback already submitted for #{@day_label} meal."
    end
  end

  def set_feedback_messages
    if !@daily_meal_record.snack && !@daily_meal_record.dinner
      flash.now[:alert] = "You did not select a snack or dinner #{@day_label}, so you are not eligible for feedback."
    elsif @daily_meal_record.snack && !@daily_meal_record.dinner
      flash.now[:notice] = "You selected a snack #{@day_label}. You can only provide feedback for snacks."
    elsif !@daily_meal_record.snack && @daily_meal_record.dinner
      flash.now[:notice] = "You selected dinner #{@day_label}. You can only provide feedback for dinner."
    else
      flash.now[:notice] = "You selected both snack and dinner #{@day_label}. Please provide your feedback!"
    end
  end

  def feedback_params
    params.require(:feedback).permit(:rating_for_snack, :rating_for_dinner, :comments_for_dinner)
  end
end
