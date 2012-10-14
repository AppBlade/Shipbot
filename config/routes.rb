TwoHundredTwentyTwo::Application.routes.draw do

  resources :xcode_projects, :only => :index
  resources :repositories, :only => [:index, :new, :create, :update]

  resources :developer_certificates

  resources :build_rules, :only => [:new, :create]
  resources :native_targets, :only => [] do
    resources :build_rules, :expect => [:index, :show]
  end

  resources :provisioning_profiles, :except => [:edit, :update]

  root :to => 'pages#index'

  match '/:service/oauth/start'    => 'oauth#new',    :as => :oauth_authorize
  match '/:service/oauth/callback' => 'oauth#create', :as => :oauth_callback
  match '/access_key' => redirect('/')

  post '/github/webhook' => 'push#create'

end
