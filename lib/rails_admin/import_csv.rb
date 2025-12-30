module RailsAdmin
  module Config
    module Actions
      class ImportCsv < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          false
        end

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :link_icon do
          'fa fa-upload' # Example: Upload icon
        end
        
        register_instance_option :controller do
          proc do
            if request.post?
              file = params[:csv_file]
              if file
                errors = []
                CSV.foreach(file.path, headers: true) do |row|
                  employee_data = row.to_h

                  # Ensure password and password_confirmation match
                  if employee_data["password"] == employee_data["password_confirmation"]
                    Employee.create!(employee_data)
                  else
                    errors << "Password mismatch for #{employee_data['email']}"
                  end
                end

                if errors.any?
                  flash[:error] = errors.join(", ")
                else
                  flash[:success] = "Employees imported successfully!"
                end
              else
                flash[:error] = "No file selected."
              end
              redirect_to back_or_index
            end
          end
        end
      end
    end
  end
end
