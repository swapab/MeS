MeSpring::Application.routes.draw do
  resources :employees do
    get :grouped, on: :collection
  end

  root to: 'employees#index'
end
