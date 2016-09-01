Rails.application.routes.draw do
  get '/learning', to: 'static_pages#learning'
  get '/populating', to: 'static_pages#populating'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
