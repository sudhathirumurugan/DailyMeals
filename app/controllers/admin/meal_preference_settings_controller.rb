class Admin::MealPreferenceSettingsController < ApplicationController
    before_action :authorize_admin
  
    # Index action for displaying the meal preference settings list
    def index
      @date = Date.today 
      @settings = MealPreferenceSetting.order(date: :desc) # Get all settings ordered by date
      @meal_preference_setting = MealPreferenceSetting.new  # Initialize a new meal preference setting object for the form
      # Fetch if the setting is enabled for the current date
      @meal_preference_enabled = MealPreferenceSetting.find_by(date: Date.today)&.enabled || false
    end
  
    # Create action for saving a new or updating an existing meal preference setting
    def create
      # If the date is provided in the form, parse it, else use today
      date = meal_preference_params[:date].present? ? Date.parse(meal_preference_params[:date]) : Date.today
      
      # Restrict changes after 12 PM
    #   if Time.now.hour >= 12
    #     flash[:alert] = "Preferences can only be changed before 12 PM."
    #     redirect_to admin_meal_preference_settings_path and return
    #   end
      
      # Find or initialize the setting for the given date
      setting = MealPreferenceSetting.find_or_initialize_by(date: date)
      setting.user_id = current_user.id   # Set the current admin user as the user for the setting
      setting.enabled = meal_preference_params[:enabled] == "true"  # Convert the string to a boolean
      
      # Save the setting and provide feedback
      if setting.save
        flash[:notice] = "Meal preference setting updated successfully."
      else
        flash[:alert] = "Failed to update setting."
      end
      
      # Redirect back to the index page
      redirect_to admin_meal_preference_settings_path
    end
  
    private
  
    # Ensure only admin users have access to this controller
    def authorize_admin
      redirect_to root_path, alert: "Access Denied" unless current_user.admin?
    end
  
    # Strong parameters to allow date and enabled values
    def meal_preference_params
      params.require(:meal_preference_setting).permit(:date, :enabled)
    end
  end
  