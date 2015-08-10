Rails.application.routes.draw do
  root "static_pages#fb2"
  get "fb1" => "static_pages#fb1"
  get "fb2" => "static_pages#fb2"
  get "directory_listing" => "static_pages#directory_listing"
end
