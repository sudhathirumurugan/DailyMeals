class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user&.is_a?(Admin)
  end
  
  def current_admin
    current_user if current_user.is_a?(Admin)
  end
  
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_daily_meal_records_path # Redirect to /admin/daily_meal_records
    elsif resource.employee?
      flash[:notice] = "Welcome, #{current_user.name}!"
      new_employee_daily_meal_record_path
    else
      root_path
    end
  end
end
