Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/receipts/process", to: "receipts#create", as: :receipts
  get "/receipts/:id/points", to: "receipts#show", as: :receipt_points
end
