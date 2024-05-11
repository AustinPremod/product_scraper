Rails.application.routes.draw do
  devise_for :users
  authenticate :user do
    ActiveAdmin.routes(self)
  end
end
