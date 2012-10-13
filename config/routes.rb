TwoHundredTwentyTwo::Application.routes.draw do

  resources :developer_certificates

  resources :provisioning_profiles, :except => [:edit, :update]

  root :to => 'pages#index'

end
