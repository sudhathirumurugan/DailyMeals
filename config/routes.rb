Rails.application.routes.draw do

  # constraints(lambda { |req| req.session[:user_type] == "admin" }) do
  #   root to: "admin/daily_meal_records#index"
  # end
 
  # constraints(lambda { |req| req.session[:user_type] == "user" }) do
  #   root to: "users/daily_meal_records#new"
  # end
 
  # Default root route
    root "home#index"

    devise_for :users, controllers:
    {
      registrations: "users/registrations",
      confirmations: "users/confirmations",
      sessions: "users/sessions",
      passwords: "users/passwords"
    }

    namespace :employee do
      resources :daily_meal_records, except: [:index]
      resources :feedbacks, only: [:new, :create] do
        collection do
          get "no_feedback"
        end
      end
    end
  
    # meal_preference_settings
    namespace :admin do
      resources :meal_preference_settings, only: [:index, :create]
    end

    # CSV export works
    namespace :admin do
      resources :daily_meal_records, only: [:index] do
        collection do
          get :download_csv, defaults: { format: 'csv' } # Separate CSV route
        end
      end
    end
    
    
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :daily_meal_records, only: [ :index ]
    resources :feedbacks, only: [ :index ]
  end

  get "employees/dashboard"
  get "admins/dashboard"



  mount RailsAdmin::Engine => "/admin", as: "rails_admin"


  authenticate :user, ->(u) { u.employee? } do
    get "employee_dashboard", to: "employees#dashboard"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
