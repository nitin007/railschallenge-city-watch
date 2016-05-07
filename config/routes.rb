Rails.application.routes.draw do
  resources :emergencies, only: [:edit, :new, :destroy]
end
