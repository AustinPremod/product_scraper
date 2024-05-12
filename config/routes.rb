# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  authenticate :user do
    ActiveAdmin.routes(self)
  end
  namespace :api do
    namespace :v1 do
      resources :products, only: [] do
        post :scraped_data, on: :collection
      end
    end
  end
end
