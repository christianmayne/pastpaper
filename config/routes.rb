Pastpaper::Application.routes.draw do

  #get "errors/error_404"
  #get "errors/error_500"

	get "offer/new"
	post "offer/create"
	post "mailing_lists/create"

	resources :gedcom_documents

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
			match 'publish/:id' => 'documents#publish',:as => :publish
			match 'unpublish/:id' => 'documents#unpublish',:as => :unpublish
		end
		match '/people_facts_locations' => 'documents#people_facts_locations',:as => :people_facts_loc
		resources :document_attributes
		resources :locations
		resources :document_photos
		resources :people
		#resources :document_facts
		resource :facts
		resources :document_photos
		resources :comments

	end

	get 'locations/autocomplete_location_street1'
	get 'locations/autocomplete_location_street2'
	get 'locations/autocomplete_location_town'
	get 'locations/autocomplete_location_county'
	get 'locations/autocomplete_location_state'
	get 'locations/autocomplete_location_country'

	#resources :people do
	#	resources :documents
	#end	

	match 'payments/cancel' => 'payments#paypal_cancel',:as => 'paypal_cancel'
	match 'payments/success' => 'payments#paypal_return',:as => 'paypal_return'
	match 'payments/ipn' => 'payments#create',:as => 'paypal_ipn'
	
	resources :home do 
		collection do
			#get 'document_search','simple_location_search','date_search','simple_people_search','simple_organisation_search','document_filter'
			#get 'search_results'
			#post 'search_results'
			get 'search_people'
			get 'search_locations'
			get 'search_publications'
			get 'search_dates'
			#post 'search_people'
			#get 'search_results_person'
			#post 'search_results_person'
		end
	end

	match 'documents/document_image_remove/:id' => 'document_photos#remove_image',:as=>"remove_image"
	match 'documents/make_primary_image/:id' => 'document_photos#make_primary_image',:as => :make_primary_image
	match 'person_detail/:id' => 'documents#person_detail',:as=>'person_detail'

	#match 'warmemorial' => 'documents#warmemorial_new'

	#static pages
	match 'about', :to=> 'pages#about'
	match 'contact', :to => 'pages#contact'
	match 'privacy', :to => 'pages#privacy'
	match 'terms', :to => 'pages#terms'
	match 'help', :to => 'pages#help'

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

	# Browse Links
	match 'surnames' => 'people#surnames'
	match 'surnames/:last_name' => 'people#surname_search'
	match 'tags' => 'documents#tags'
	match 'documents/tag/:id' => 'documents#tag'

	match 'bibles' => 'documents#bibles'
	match 'bibles_list' => 'documents#bibles_list'
	match 'books' => 'documents#books'
	match 'certificates' => 'documents#certificates'
	match 'deeds' => 'documents#deeds'
	match 'diaries' => 'documents#diaries'
	match 'directories' => 'documents#search_directories'
	match 'search_directories' => 'documents#search_directories'
	match 'ephemera' => 'documents#ephemera'
	match 'indentures' => 'documents#indentures'
	match 'journals' => 'documents#journals'
	match 'letters' => 'documents#letters'
	match 'magazines' => 'documents#magazines'
	match 'maps' => 'documents#search_maps'
	match 'search_maps' => 'documents#search_maps'
	match 'marriage-settlements' => 'documents#marriage_settlements'
	match 'newspapers' => 'documents#search_newspapers'
	match 'search_newspapers' => 'documents#search_newspapers'
	match 'notebooks' => 'documents#notebooks'
	match 'photos' => 'documents#photos'
	match 'postcards' => 'documents#postcards'
	match 'warmemorials' => 'documents#warmemorials'
	match 'wills' => 'documents#wills'

	match 'rollofhonour' => 'people#rollofhonour'
	
	
	#match 'search_publications' => 'documents#search_publications'

	root :to => 'home#index'

	match "/sitemap.:format",
     :controller => "home",
     :action => "sitemap",
     :conditions => { :method => :get }

	# Error handling
	# To test in development, remove condition
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end

end
