# frozen_string_literal: true

Rails.application.routes.draw do
  resources :product, only: [:show, :index]

  resources :reviews, only: [:index, :create] do
    collection do
      get '/product/:product_id', to: 'reviews#product', as: :product
    end
  end
end
