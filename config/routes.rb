TwoHundredTwentyTwo::Application.routes.draw do

  resources :xcode_projects, :only => :index

  resources :developer_certificates

  resources :provisioning_profiles, :except => [:edit, :update]

  root :to => 'pages#index'

  match '/:service/oauth/start',     :to => 'oauth#new',    :as => :oauth_authorize
  match '/:service/oauth/callback',  :to => 'oauth#create', :as => :oauth_callback
  match '/access_key', :to => 'pages#index', :as => :access_key

end
