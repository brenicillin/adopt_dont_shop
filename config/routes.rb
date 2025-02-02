Rails.application.routes.draw do
  root 'welcome#index'
  get '/', to: 'applications#welcome'

  get '/applications', to: 'applications#index'
  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'
  get '/applications/:id', to: 'applications#show'
  post '/applications/:id/add_pet', to: 'applications#add_pet', as: :add_pet_application



  post '/pet_applications', to: 'pet_applications#create'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/veterinary_offices', to: 'veterinary_offices#index'
  get '/veterinary_offices/new', to: 'veterinary_offices#new'
  get '/veterinary_offices/:id', to: 'veterinary_offices#show'
  post '/veterinary_offices', to: 'veterinary_offices#create'
  get '/veterinary_offices/:id/edit', to: 'veterinary_offices#edit'
  patch '/veterinary_offices/:id', to: 'veterinary_offices#update'
  delete '/veterinary_offices/:id', to: 'veterinary_offices#destroy'

  get '/veterinarians', to: 'veterinarians#index'
  get '/veterinarians/:id', to: 'veterinarians#show'
  get '/veterinarians/:id/edit', to: 'veterinarians#edit'
  patch '/veterinarians/:id', to: 'veterinarians#update'
  delete '/veterinarians/:id', to: 'veterinarians#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians'
  get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new'
  post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create'

  get '/admin/shelters', to: 'admin_shelters#index'
  get '/admin/applications', to: 'admin_applications#index', as: :admin_applications
  get '/admin/applications/:id', to: 'admin_applications#show', as: :admin_application
  patch '/admin/applications/:id/pets/:pet_id/approve', to: 'applications#approve_pet', as: :approve_pet_application
  patch '/admin/applications/:id/pets/:pet_id/reject', to: 'applications#reject_pet', as: :reject_pet_application

end
