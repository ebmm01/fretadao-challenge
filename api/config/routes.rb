Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :users,  only: [:index, :create]
    put "rescrapper/:id" => "users#rescrapper"
    get "search/:text" => "users#search"
end
