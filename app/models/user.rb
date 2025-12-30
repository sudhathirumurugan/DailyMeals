class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      #  :confirmable


  validate :password_check

  def password_check
    if password.present?
      unless password.match?(/\A(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+\z/)
        errors.add(:password, "must include at least one uppercase letter, one digit, and one special character")
      end
    end
  end

  # Single Table Inheritance
  self.inheritance_column = :type

  # Ensure role is set
  after_initialize :set_default_type, if: :new_record?
  # before_create :auto_confirm_admin

  # Associations
  has_many :daily_meal_records  
  has_many :feedbacks

  def admin?
    type == "Admin"
  end

  def employee?
    type == "Employee"
  end
  private

  # def auto_confirm_admin
  #   if type == "Admin"
  #     self.skip_confirmation! if type == "Admin"
  #   end
  # end


  private

  def set_default_type
    self.type ||= "Employee"
  end
end
