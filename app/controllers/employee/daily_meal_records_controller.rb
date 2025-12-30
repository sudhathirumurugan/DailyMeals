class Employee::DailyMealRecordsController < ApplicationController
  before_action :authenticate_user!


  # before_action :check_access_time, only: [:create] # Restrict access based on time


  before_action :set_daily_meal_record, only: [:show, :edit, :update, :destroy]
  # before_action :check_access_time, only: [:create, :update] # Restrict access based on time


    # GET /daily_meal_records/new
    def new
      @daily_meal_record = current_user.daily_meal_records.find_by(date: Date.today)
      @meal_preference_enabled = MealPreferenceSetting.find_by(date: Date.today)&.enabled || false
      if @daily_meal_record.present?
        redirect_to employee_daily_meal_record_path(@daily_meal_record.id) and return
      else
        @daily_meal_record = current_user.daily_meal_records.new(date: Date.today)
        render :new
      end
    end
    
    
    # POST /daily_meal_records
    def create
      params[:daily_meal_record][:meal_type] ||= 0  # Default to 0 if not provided
      existing_record = check_duplicate_record  # Capture the duplicate record
    
      if existing_record
        redirect_to employee_daily_meal_record_path(existing_record), notice: "Meal already recorded!"
      else
        @daily_meal_record = current_user.daily_meal_records.new(meal_params)

        @daily_meal_record.meal_type = params[:daily_meal_record][:meal_type].to_i if params[:daily_meal_record][:meal_type].present?
        
        @daily_meal_record.date = Date.today
        @daily_meal_record.user_id = current_user.id # Assign user_id
    
        if @daily_meal_record.save
          redirect_to employee_daily_meal_record_path(@daily_meal_record), notice: "Meal added successfully!"
        else
          flash.now[:alert] = "Failed to add meal. Please try again."
          render :new
        end
      end
    end
    
    # GET /daily_meal_records
  def show
    @daily_meal_record = DailyMealRecord.find_by(user_id: current_user.id, date: Date.today)
    @meal_preference_enabled = MealPreferenceSetting.find_by(date: Date.today)&.enabled || false
    unless @daily_meal_record
      redirect_to new_employee_daily_meal_record_path, alert: "No meal record found for today."
    end
  end

  # GET /daily_meal_records/:id/edit
  def edit
    @daily_meal_record = current_user.daily_meal_records.find_by(date: Date.today)
    unless @daily_meal_record
      redirect_to new_employee_daily_meal_record_path, alert: "No meal record found for today."
    end
    @meal_preference_enabled = MealPreferenceSetting.find_by(date: Date.today)&.enabled || false
  end
  
  # PATCH/PUT /daily_meal_records/:id
  def update
    @daily_meal_record = current_user.daily_meal_records.find_by(date: Date.today)

    if params[:daily_meal_record][:dinner] == "false"
      params[:daily_meal_record][:chapati_count] = 0
    end

    if @daily_meal_record.update(meal_params)
      redirect_to employee_daily_meal_record_path(@daily_meal_record), notice: "Meal record updated successfully!"
    else
      flash.now[:alert] = "Failed to update meal record."
      render :edit
    end
  end

  # DELETE /daily_meal_records/:id
  def destroy
    @daily_meal_record = current_user.daily_meal_records.find_by(date: Date.today)
    if @daily_meal_record&.destroy
      redirect_to new_employee_daily_meal_record_path, notice: "Meal record deleted successfully!"
    else
      redirect_to new_employee_daily_meal_record_path, alert: "Error deleting meal record."
    end
  end
  
    private
    # Strong parameters
    def meal_params
      params.require(:daily_meal_record).permit(:date, :snack, :dinner, :chapati_count, :meal_type)
    end

    def check_duplicate_record
      current_user.daily_meal_records.find_by(date: Date.today)
    end

    def set_daily_meal_record
      @daily_meal_record = current_user.daily_meal_records.find_by(date: Date.today)
    end

    # def check_access_time
    #   current_hour = Time.now.hour
    #   current_min = Time.now.min

    #   unless current_hour == 12 || (current_hour == 13 && current_min == 0) # Allows from 12:00 to 12:59 PM
    #     redirect_to new_employee_daily_meal_record_path, alert: "You can only access meals between 12:00 PM and 1:00 PM."
    #   end
    # end

    def check_access_time
      current_time = Time.now.utc.in_time_zone("Asia/Kolkata")
      formatted_time = current_time.strftime("%I:%M %p") # Display time in 12-hour format with AM/PM
      current_hour = current_time.hour
      current_min = current_time.min

      unless current_hour == 12 || (current_hour == 13 && current_min == 0) # Allows from 12:00 to 12:59 PM IST
         redirect_to new_employee_daily_meal_record_path, alert: "You can only access meals between 12:00 PM and 1:00 PM IST. Current time: #{formatted_time}."
      end
    end
end
