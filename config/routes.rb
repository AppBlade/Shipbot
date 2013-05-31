TwoHundredTwentyTwo::Application.routes.draw do

  resources :xcode_projects, :only => :index
  resources :repositories, :only => [:index, :new, :create, :update]

  resources :developer_certificates, :only => [:edit, :update]
  resources :build_tasks, :only => :index do
    resources :build_task_results, :only => :create
  end
  resources :build_task_results, :only => :show

  resources :build_rules, :only => [:new, :create]
  resources :native_targets, :only => [] do
    resources :build_rules, :expect => [:index, :show]
  end

  resources :provisioning_profiles, :except => [:edit, :update]

  resources :users, :only => [:show, :edit]


  match '/users' => 'user#show'
  match '/edit_user' => 'user#edit'
  match '/sign_in' => 'user#create'



  root :to => 'pages#index'

  match '/:service/oauth/start'    => 'oauth#new',    :as => :oauth_authorize
  match '/:service/oauth/callback' => 'oauth#create', :as => :oauth_callback
  match '/access_key' => redirect('/')

  post '/github/webhook' => 'push#create'

end
