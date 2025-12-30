class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_employee

  # def dashboard
  # end

  private

  def authorize_employee
    redirect_to root_path, alert: "Access Denied" unless current_user.employee?
  end
end
