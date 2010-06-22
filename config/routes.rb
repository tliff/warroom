Warroom::Application.routes.draw do |map|
  devise_for :users


  resources :sources
  
  resources :reports

  resources :secrets

  resources :graphs do
    member do
      post :updatesources      
    end
    resources :graph_lines do
      member do
        get :day
        get :week
        get :month
        get :quarter
        get :year
      end
    end
  end

  root :to => "info#index"

end
