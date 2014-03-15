MeSpring::Application.routes.draw do
  resources :employees do
    get :grouped, on: :collection
    get :archived, on: :collection
  end

  root to: 'employees#index'
end
