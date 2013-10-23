ChoremateApi::Application.routes.draw do
  # post 'user/login', :controller => 'users', :action => 'login'

  resources :users do
    collection do
      post :login
    end
  end

  resources :households do

    member do
      post :add_members
    end

    resource :invites, controller: :household_invites do
      root to: :index, via: :get
      root to: :create, via: :post
      root to: :accept, via: :put
      root to: :reject, via: :delete
    end

    resources :chores

    resources :suggestions

    resources :votes

  end



end
