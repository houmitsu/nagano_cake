Rails.application.routes.draw do

    devise_for :admins, :controllers => { :registrations => 'admins/registrations', :sessions => 'admins/sessions'}
    devise_for :customers, :controllers => { :registrations => 'customers/registrations', :sessions => 'customers/sessions'}

    #admin
  namespace :admin do
    #homes
    root to: 'homes#top'

    #items
    resources :items, only:[:index, :new, :create, :show, :edit, :update]

    #genres
    resources :genres, only:[:index, :create, :edit, :update]

    #customers
    resources :customers, only:[:index, :show, :edit, :update]

    #orders
    resources :orders, only:[:show, :update]

    #oeder
    resources :order_items, only:[:update]

  end

    #public
  scope module: :public do

    #homes
    root to: 'homes#top'
    get '/about' => 'homes#about'

    #addresses
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]

    #orders
    get '/orders/thanks' => 'orders#thanks'
    post '/orders/verification' => 'orders#verification'
    resources :orders, only:[:index, :new, :show, :create]

    #cart_items
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only:[:index, :create, :update, :destroy]

    #customers
    get '/customers/verification' => 'customers#verification'
    patch '/customers/withdrawal' => 'customers#withdrawal'
    get '/customer/edit' => 'customers#edit', as: 'edit_customers'
    patch '/customer' => 'customers#update', as: 'update_customers'
    get '/customer' => 'customers#show', as: 'customers'

    #items
    get '/items' => 'items#index'
    get '/items/:id' => 'items#show', as: 'items_show'

  end

end
