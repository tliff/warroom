Warroom::Application.routes.draw do |map|

  resources :sources
  
  resources :reports
  resources :graphs do
    resources :graph_lines do
      member do
        get :day
      end
    end
  end

  root :to => "graphs#index"

end
