Warroom::Application.routes.draw do |map|

  resources :sources
  
  resources :reports
  resources :graphs do
    resources :graph_lines
  end

  root :to => "graphs#index"

end
