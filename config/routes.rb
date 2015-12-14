Rails.application.routes.draw do
  get 'home/index'

  # get 'users/:id/edit_user_suggestion', to: 'users#edit_user_suggestion', as: 'edit_user_suggestion'
  # put 'users/:id', to: 'users#update_user_suggestion', as: 'user_suggestion'

  # get 'users/:user_id/events/:event_id/new_user_suggestion', to: 'users#new_user_suggestion', as: 'new_user_suggestion'

  devise_for :users

  get 'users/:user_id/events/:id/determine_date', to: 'events#determine_date', as: 'determine_date'
  patch 'users/:user_id/events/:id/determine_date', to: 'events#determine_post', as: 'determine_post'
  patch 'users/:user_id/events/:id/determine_cancel', to: 'events#determine_cancel', as: 'determine_cancel'

  resources :users, only: [:update] do
    resources :events do
      resource :user_suggestion, only: [:edit]
    end
  end

  get 'users/:user_id/events/:id/show_determine', to: 'events#show_determine', as: 'show_determine'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: "home#index"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
