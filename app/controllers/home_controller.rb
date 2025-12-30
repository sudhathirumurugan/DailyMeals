class HomeController < ApplicationController
  def index
    if current_admin
      redirect_to admin_daily_meal_records_path
    else
      redirect_to new_employee_daily_meal_record_path
    end
  end
end
