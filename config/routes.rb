Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end
  # get "/receipts" => "receipts#index"
  # get "/receipts/new" => "receipts#new"
  # post "/receipts" => "receipts#create"
  # get "/receipts/:id" => "receipts#show"
  # get "/receipts/:id/edit" => "receipts#edit"
  # patch "/receipts/:id" => "receipts#update"
  # delete "/receipts/:id" => "receipts#destroy"


  namespace :api do

    post "/users" => "users#create"

    post "/sessions" => "sessions#create"

    get "/receipts" => "receipts#index"
    post "/receipts" => "receipts#create"
    get "receipts/:id" => "receipts#show"
    patch "/receipts/:id" => "receipts#update"
    delete "/receipts/:id" => "receipts#destroy"

    post "/receipts_analyze" => "receipts#analyze"

     
   

    
    
   
  end
end
