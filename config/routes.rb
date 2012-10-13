TwoHundredTwentyTwo::Application.routes.draw do

  resources :xcode_projects, :only => :index
  resources :repositories, :only => :index

  resources :developer_certificates

  resources :provisioning_profiles, :except => [:edit, :update]

  root :to => 'pages#index'

  match '/:service/oauth/start'    => 'oauth#new',    :as => :oauth_authorize
  match '/:service/oauth/callback' => 'oauth#create', :as => :oauth_callback
  match '/access_key' => redirect('/')

end
