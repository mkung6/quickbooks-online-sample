require 'sidekiq/web'
require 'constraints/admin_constraint'

Rails.application.routes.draw do
  root 'status#index'

  resources :invoices, only: [:index, :update, :show, :create, :destroy] do
    collection do
      get 'oauth'
    end
  end

  mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new
end
