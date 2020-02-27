Rails.application.routes.draw do
  
  root 'companies#top'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }

  resources :users, only: [:show, :edit, :update]

  post 'rooms/:room_id/messages' => 'messages#create', as: "messages"
  get 'search' => 'recruits#search'
  get 'entries' => 'entries#index'
  get 'bookmarks' => 'bookmarks#index'
  get 'follows' => 'follows#index'

  resources :companies, only: [:show, :new, :create] do
    get 'users/:id/become_employee' => 'users#become_employee', as: 'become_employee'
    resources :rooms, only: [:show]
    resources :follows, only: [:create, :destroy]
  end

  get 'companies/:id/feeds' => 'feeds#company_feed', as: 'company_feed'
  get 'companies/:id/recruits' => 'recruits#company_index', as: 'company_index'
  get 'companies/:id/about' => 'companies#about', as: 'about'
  get 'companies/:id/members' => 'companies#member', as: 'member'

  resources :recruits, only: [:index, :show] do
    resources :entries, only: [:create]
    resources :supports, only: [:create]
    resources :bookmarks, only: [:create, :destroy]
  end  

  resources :feeds, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
  end

  namespace :admin do
    post 'companies/:compnay_id/users/:id/add_employee' => 'companies#add_employee', as: 'add_employee'
    post 'companies/:company_id/users/:id/add_authority' => 'companies#add_authority', as: 'add_authority'
    get 'companies/:id/home' => 'companies#home'
    get 'companies/:id/users' => 'companies#employee_index', as: 'employee_index'
    get 'companies/:id/invite' => 'companies#invite', as: 'invite'
    get 'companies/:id/invite_new' => 'companies#invite_new', as: 'invite_new'
     
    resources :companies, only: [:edit, :update, :destroy] do
      resources :feeds
      resources :recruits
      get 'candidates/:id' => 'entries#candidate_show', as: "candidate_show"
      get 'candidates' => 'entries#candidate_list'
    end 

    post 'companies/:company_id/users/:id/remove_employee' => 'companies#remove_employee', as: 'remove_employee'
    post 'companies/:company_id/users/:id/remove_authority' => 'companies#remove_authority', as: 'remove_authority'

    get 'scouts/search' => 'scouts#search'
    post 'users/:user_id/scouts' => 'scouts#create', as: 'scouts'
  end  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
