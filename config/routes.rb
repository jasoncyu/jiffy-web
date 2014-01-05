JiffyAnalysisRails::Application.routes.draw do
  resources :goals
  resources :weeks

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'reports#index'
  get 'reports' => 'reports#index'
  get 'reports/week' => 'reports#pick_week'
  get 'reports/week/:week' => 'reports#report_week'
  get 'reports/project/:id/week' => 'reports#project_level_pick_week'
  get 'reports/project/:id/week/:week' => 'reports#report_project_week'
  post 'reports/refresh' => 'reports#refresh'

  get 'project/:id' => 'reports#project'
  get 'project/:id/week/:week' => 'reports#project'
  get 'project/:id/tasks' => 'projects#tasks'

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
