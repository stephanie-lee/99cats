Rails.application.routes.draw do
  # root to: :cats
  resources :cats
  resources :cat_rental_requests
end
