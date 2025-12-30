class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :daily_meal_record

  validates :comments_for_dinner, length: { maximum: 500 }, allow_nil: true
  validates :rating_for_snack, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }
  validates :rating_for_dinner, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true }

  validate :validate_snack_rating
  validate :validate_dinner_rating

  private

  def snack_selected?
    daily_meal_record&.snack.to_s.downcase == "true"
  end

  def dinner_selected?
    daily_meal_record&.dinner.to_s.downcase == "true"
  end

  def validate_snack_rating
    if snack_selected? && rating_for_snack.blank?
      errors.add(:rating_for_snack, "Rating is required when snack is selected.")
    elsif rating_for_snack.present? && !snack_selected?
      errors.add(:rating_for_snack, "You can only rate snacks if you selected them.")
    end
  end

  def validate_dinner_rating
    if dinner_selected? && rating_for_dinner.blank?
      errors.add(:rating_for_dinner, "Rating is required when dinner is selected.")
    elsif rating_for_dinner.present? && !dinner_selected?
      errors.add(:rating_for_dinner, "You can only rate dinner if you selected it.")
    end
  end
end
