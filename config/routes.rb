Warroom::Application.routes.draw do |map|

  resources :sources
  
  resources :reports

  root :to => "sources#index"

end
