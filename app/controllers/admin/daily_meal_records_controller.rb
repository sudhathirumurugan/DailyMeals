class Admin::DailyMealRecordsController < ApplicationController
    before_action :authorize_admin
    require 'csv' # download a csv file

    def index
      @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
      @meal_type = params[:meal_type]

      @meal_records = DailyMealRecord.where(date: @date)
      @meal_preference_enabled = MealPreferenceSetting.find_by(date: Date.today)&.enabled || false

      @snack_count = @meal_records.where(snack: true).count 
      @dinner_count = @meal_records.where(dinner: true).count
      @total_chapati_count = @meal_records.sum( :chapati_count)

      if @meal_preference_enabled
        @veg_snack_count = @meal_records.where(meal_type: DailyMealRecord::VEG, snack: true).count
        @veg_dinner_count = @meal_records.where(meal_type: DailyMealRecord::VEG, dinner: true).count
        @veg_chapati_count = @meal_records.where(meal_type: DailyMealRecord::VEG).sum(:chapati_count)

        @non_veg_snack_count = @meal_records.where(meal_type: DailyMealRecord::NON_VEG, snack: true).count
        @non_veg_dinner_count = @meal_records.where(meal_type: DailyMealRecord::NON_VEG, dinner: true).count
        @non_veg_chapati_count = @meal_records.where(meal_type: DailyMealRecord::NON_VEG).sum(:chapati_count)
      end

      if @meal_type == "snacks"
        @meal_records = @meal_records.where(snack: true)
      elsif @meal_type == "dinner"
        @meal_records = @meal_records.where(dinner: true)
      end

      # To generate csv file
      respond_to do |format|
        format.html
      end
    end

    def download_csv
      @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
      @meal_records = DailyMealRecord.where(date: @date)

      if @meal_records.empty?
        redirect_to admin_daily_meal_records_path, alert: "No records found for #{@date.strftime("%d-%m-%Y")}"
        return
      end
    
      send_data generate_csv(@meal_records), filename: "meal_records-#{Date.today}.csv", type: 'text/csv'
    end

    private
    # def authorize_admin
    #   redirect_to root_path(format: :html), alert: "Access Denied" unless current_user.admin?
    # end
    
    def authorize_admin
      unless current_user.admin?
        respond_to do |format|
          format.html { redirect_to root_path, alert: "Access Denied" }
          format.csv { head :forbidden } # Prevents CSV download if unauthorized
        end
      end
    end

    
    def generate_csv(meal_records)
      CSV.generate(headers: true) do |csv|
         # Get today's date
        formatted_date = Date.today.strftime("%d-%m-%Y")

        # Add an empty row for spacing
        csv << []

        csv << [formatted_date.center(50)] 

        csv << []

        # Header row
        csv << ["Employee Name", "Snack", "Dinner", "Chapati Count", "Meal Type"] 
        
        # Veg_count
        veg_snack_count = 0
        veg_dinner_count =0
        veg_chapati_count = 0

        # Non _veg_count
        non_veg_snack_count = 0
        non_veg_dinner_count = 0
        non_veg_chapati_count = 0

        #Not_specified  
        not_specified_snack_count = 0
        not_specified_dinner_count = 0
        not_specified_chapati_count = 0

        #Total_count
        total_snack_count = 0
        total_dinner_count = 0
        total_chapati_count = 0

       
        meal_records.each do |record|
            # Update totals only if Dinner is Yes
            chapati_to_add = record.dinner ? record.chapati_count.to_i : 0
        
            meal_type_text = case record.meal_type
            when 1 then "Veg"
            when 2 then "Non Veg"
            else "Not Specified"
            end

            csv << [
            record.user.name,
            record.snack ? "Yes" : "No",
            record.dinner ? "Yes" : "No",
            chapati_to_add,
            meal_type_text
          ]

          case record.meal_type
          when 1 # Veg
            veg_snack_count += 1 if record.snack
            veg_dinner_count += 1 if record.dinner
            veg_chapati_count += chapati_to_add
          when 2 # Non_veg
            non_veg_snack_count += 1 if record.snack
            non_veg_dinner_count += 1 if record.dinner
            non_veg_chapati_count += chapati_to_add
          else  #Not_specified
            not_specified_snack_count += 1 if record.snack
            not_specified_dinner_count += 1 if record.dinner
            not_specified_chapati_count += chapati_to_add
          end

            total_snack_count += 1 if record.snack
            total_dinner_count += 1 if record.dinner
            total_chapati_count += chapati_to_add
        end

        csv << []

        # Add Total Count Section
        csv << ["Total Meal Count Section"]
        csv << ["Meal Type", "Snack Count", "Dinner Count", "Chapati Count"]
        csv << ["Veg", veg_snack_count, veg_dinner_count, veg_chapati_count]
        csv << ["Non Veg", non_veg_snack_count, non_veg_dinner_count, non_veg_chapati_count]
        csv << ["Not Specified", not_specified_snack_count, not_specified_dinner_count, not_specified_chapati_count]
        csv << ["Overall", total_snack_count, total_dinner_count, total_chapati_count]  
      end
    end
end

