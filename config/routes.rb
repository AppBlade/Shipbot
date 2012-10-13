TwoHundredTwentyTwo::Application.routes.draw do

  resources :provisioning_profiles, :except => [:edit, :update]

  root :to => 'pages#index'

end
