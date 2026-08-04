Rails.application.routes.draw do
  devise_for :users

  # API Endpoints (v1)
  namespace :api do
    namespace :v1 do
      resources :departments
      resources :attendance_records, only: [:index] do
        collection do
          post :clock_in
          post :clock_out
        end
      end
      resources :leave_requests, only: [:index, :show, :create] do
        member do
          post :approve
          post :reject
        end
      end
    end
  end

  # Healthcheck and root
  get "up" => "rails/health#show", as: :rails_health_check
  root to: redirect("/api-docs/index.html")
end
