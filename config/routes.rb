Pastpaper::Application.routes.draw do
 
  get "offer/new"
  post "offer/create"
  post "mailing_lists/create"

  resources :gedcom_documents

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  get 'logout' => 'sessions#destroy', :as => 'logout'
  post 'login' => 'sessions#create', :as => 'login'
  match 'forgot_password' => 'password_resets#new',:as=>'forgot_password'
  get 'profile' => 'users#index', :as => 'user_home'
  
  match 'account/deactivate' => 'users#accountdeactivate' ,:as =>'deactivateaccount'
  match 'account/changepassword' => 'users#changepassword',:as=>'changepassword'

  match 'user/registration' => 'users#new', :as => 'register'
  resources :users
  resources :password_resets
  match 'password_resets/:id/edit' => "password_resets#edit" ,:as => 'password_reset_path'
  
  resources :documents do 
    collection do 
      match 'permanent_delete/:id' => 'documents#permanently_delete',:as => :permanent_delete
    end
    #match '/authorinfo' => 'documents#authorinfo',:as => :authorinfo
    # CM >
    match '/publicationinfo' => 'documents#publicationinfo',:as => :publicationinfo
    match '/images' => 'documents#itemimages' ,:as => :itemimages
    match '/locations' => 'documents#locations',:as => :locations
    match '/document_locations' => 'documents#locations',:as => :locations
    match '/itempeople'  => 'documents#itempeople' ,:as => :itempeople
    match '/people_facts_locations' => 'documents#people_facts_locations',:as => :people_facts_loc
    resources :document_locations
    resources :locations, :controller=>"document_locations"
    resources :people ,:controller => "document_people"
    resources :document_facts
    resource :facts
    resources :document_photos
  end
  
  match 'payments/cancel' => 'payments#paypal_cancel',:as => 'paypal_cancel'
  match 'payments/success' => 'payments#paypal_return',:as => 'paypal_return'
  match 'payments/ipn' => 'payments#create',:as => 'paypal_ipn'
  
  resources :home do 
    collection do
      get 'document_search','simple_location_search','date_search','simple_people_search','simple_organisation_search','document_filter'
      get 'search_results'
      post 'search_results'
    end
  end

  #match 'documents/authorinfo/:id' => 'documents#authorinfo',:as => :authorinfo
  # CM >
  match 'documents/publicationinfo/:id' => 'documents#publicationinfo',:as => :publicationinfo
  match 'documents/update/publishinginfo/:id' => 'documents#publishinginfo',:as => :publishinginfo 
  match 'documents/document_image_remove/:id' => 'documents#remove_image',:as=>"remove_image"
  match 'documents/make_primary_image/:id' => 'documents#make_primary_image',:as => :make_primary_image
  match 'person_detail/:id' => 'documents#person_detail',:as=>'person_detail'

  #static pages
  match 'about', :to=> 'pages#about'
  match 'contact', :to => 'pages#contact'
  match 'privacy', :to => 'pages#privacy'
  match 'terms', :to => 'pages#terms'
  match 'help', :to => 'pages#help'


  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  namespace :admin do
    resources :document_types
    resources :statuses
    resources :attribute_types
    resources :event_types
    resources :users
    resources :orders
    resources :documents
    match 'restore_document/:id' => 'Documents#restore_document', :as => 'restore_document'
    match 'report' => 'report#index' ,:as=>:report
    match 'report/surname_report' => 'report#surname_report',:as=>:surname_report
    match 'report/location_report' => 'report#location_report',:as=>:location_report
  end


  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
