RedmineApp::Application.routes.draw do
  resources :projects do
    resources :auto_rules, only: [:index, :create, :destroy] do
      get :custom_field_values, on: :collection
    end
  end
end
