Rails.application.routes.draw do
  get '/contact_us'  => 'contact_us#index'
  post '/contact_us' => 'contact_us#submit'
end
