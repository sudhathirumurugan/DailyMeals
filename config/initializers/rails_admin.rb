require_relative "../../lib/rails_admin/import_csv" # Load the import action

RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    redirect_to main_app.root_path unless current_user&.is_a?(Admin)
  end

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    import_csv # Register import_csv action
  end

  config.model 'Employee' do
    list do
      field :email
      field :name
    end

    edit do
      field :email
      field :password
      field :name
    end
  end
end
# RailsAdmin.config do |config|
#   config.asset_source = :importmap
#   config.asset_source = :sprockets
#   # RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::ImportEmployees)
#   ### Popular gems integration
# # require Rails.root.join('app/admin/import_employees') # Ensure the file is loaded
#   require Rails.root.join('lib', 'rails_admin', 'import_csv') # Ensure this file is loaded

#   ## == Devise ==
#   config.authenticate_with do
#     warden.authenticate! scope: :user  # Change this if needed
#   end
#   config.current_user_method(&:current_user)

#   config.authorize_with do
#     redirect_to main_app.root_path unless current_user&.is_a?(Admin)
#   end
  
#   config.actions do
#     dashboard do
#       statistics false
#     end
#   end

#   # Add a custom menu link to the dashboard
#   # config.navigation_static_links = {
#   #   "Daily Meal Records" => Rails.application.routes.url_helpers.admin_daily_meal_records_path
#   # }
#   # config.navigation_static_links = {
#   # "Daily Meal Records" => -> { Rails.application.routes.url_helpers.admin_daily_meal_records_path }
#   # }

  


#   ## == CancanCan ==
#   # config.authorize_with :cancancan

#   ## == Pundit ==
#   # config.authorize_with :pundit

#   ## == PaperTrail ==
#   # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

#   ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

#   ## == Gravatar integration ==
#   ## To disable Gravatar integration in Navigation Bar set to false
#   # config.show_gravatar = true
#     config.model 'Employee' do
#       list do
#         field :email
#         field :name
#       end
  
#       edit do
#         field :email
#         field :password
#         field :name
#       end
  
#       import_csv # Ensure import action is added
#     end
  
  
#   config.actions do
#     dashboard                     # mandatory
#     index                         # mandatory
#     new
#     export
#     bulk_delete
#     show
#     edit
#     delete
#     show_in_app
#     import_csv
#     ## With an audit adapter, you can add:
#     # history_index
#     # history_show
#   end

# end