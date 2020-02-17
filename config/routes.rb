Rails.application.routes.draw do
  
  root 'companies#top'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }

  resources :users, only: [:show, :edit, :update]
  resources :rooms, only: [:index, :show, :create]

  get 'search' => 'recruits#search'
  get 'entries' => 'entries#index'
  get 'bookmarks' => 'bookmarks#index'
  get 'follows' => 'follows#index'
  post 'messages' => 'messages#create'

  resources :companies, only: [:show, :new, :create] do
    resources :follows, only: [:create, :destroy]
  end

  get 'companies/:id/feeds' => 'feeds#company_feed'
  get 'companies/:id/recruits' => 'recruits#company_index'
  get 'companies/:id/about' => 'companies#about'
  get 'companies/:id/members' => 'companies#member'

  resources :recruits, only: [:index, :show] do
    resources :entries, only: [:create, :destroy]
    resources :supports, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
  end  

  resources :feeds, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
  end

  namespace :admin do
    post 'companies' => 'companies#add_employee'
    post 'companies/:id' => 'companies#remove_employee'
     
    resources :companies, only: [:edit, :update, :destroy] do
      resources :feeds
      get 'candidates' => 'entries#candidate_list'
    end 

    get 'companies/home' => 'companies#home'

    resources :recruits do
      get 'users/:id' => 'entries#candidate_show'
    end  

    get 'scouts/search' => 'scouts#search'
    get 'users/:user_id/scouts' => 'scouts#create'
  end  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
