Warroom::Application.routes.draw do |map|

  resources :sources

  root :to => "sources#index"

end
