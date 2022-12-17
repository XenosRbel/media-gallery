# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount Rswag::Api::Engine, at: "/api/docs"
    mount Rswag::Ui::Engine, at: "/api/docs"
  end

  mount Api::Engine, at: "/api"

  root 'homepage#index'
end
