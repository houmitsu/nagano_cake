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

    #homes
    root to: 'public/homes#top'
    get '/about' => 'public/homes#about'

    #addresses
    get '/addresses' => 'public/addresses#index'
    get '/addresses/:id/edit' => 'public/addresses#edit'
    post '/addresses' => 'public/addresses#create'
    patch '/addresses/:id' => 'public/addresses#update'
    delete '/addresses/:id' => 'public/addresses#destroy'

    #orders
    get '/orders/thanks' => 'public/orders#thanks'
    post '/orders/verification' => 'public/orders#verification'
    post '/orders/confirmed' => 'public/orders#confirmed'
    get '/orders' => 'public/orders#index'
    get '/orders/new' => 'public/orders#new'
    get '/orders/:id' => 'public/order#show'

    #cart_items
    delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all'
    get '/cart_items' => 'public/cart_items#index'
    post '/cart_items' => 'public/cart_items#create'
    patch '/cart_items/:id' => 'public/cart_items#update'
    delete 'cart_items/:id' => 'public/cart_items#destroy'

    #customers
    get '/customers/verification' => 'public/customers#verification'
    patch '/customers/withdrawal' => 'public/customers#withdrawal'
    get '/customers' => 'public/customers#show'
    get '/customers/edit' => 'public/customers#edit'
    patch '/customers' => 'public/customers#update'

    #items
    get '/items' => 'public/items#index'
    get '/items/:id' => 'public/items#show'

end
