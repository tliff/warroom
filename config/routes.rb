Warroom::Application.routes.draw do |map|

  resources :sources
  
  resources :reports
  resources :graphs do
    member do
      post :updatesources      
    end
    resources :graph_lines do
      member do
        get :day
      end
    end
  end

  root :to => "graphs#index"

end
