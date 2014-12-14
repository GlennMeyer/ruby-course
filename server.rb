require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'pry-byebug'

require './lib/petshop.rb'

configure do
  set :bind, '0.0.0.0'
  enable :sessions
end

def db
  PetShopServer.create_db_connection('pet_shop_server')
end

# #
# This is our only html view...
#
get '/' do
  if session[:user_id]
    # TODO: Grab user from database
    @current_user = PetShopServer::UsersRepo.user_data(db, session[:user_id])
  end
  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do
  headers['Content-Type'] = 'application/json'
  # RestClient.get("http://pet-shop.api.mks.io/shops")
  JSON.generate(PetShopServer::ShopsRepo.all_shops(db))
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  # TODO: Grab user by username from database and check password
  creds = PetShopServer::UsersRepo.authenticate(db, username)

  if password == creds['password']
    headers['Content-Type'] = 'application/json'
    # TODO: Return all pets adopted by this user
    # TODO: Set session[:user_id] so the server will remember this user has logged in
    session[:user_id] = creds['id']
    JSON.generate(creds)
  else
    status 401
  end
end

 # # # #
# Cats #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Grab from database instead
  data = PetShopServer::CatsRepo.all_cats(db, params[:id])
  data.each{ |cat| cat['adopted'] = (cat['adopted'] == 't' ? true : false )}
  JSON.generate(data)
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  owner_id = session[:user_id]
  # TODO: Grab from database instead
  result = PetShopServer::CatsRepo.adopt(db, {
    'ownerId' => owner_id, 'id' => id, 'shopId' => shop_id })
  # TODO (after you create users table): Attach new cat to logged in user
  JSON.generate(result)
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  # TODO: Update database instead
  data = PetShopServer::DogsRepo.all_dogs(db, params[:id])
  data.each { |dog| dog['adopted'] = (dog['adopted'] == 't' ? true : false )}
  JSON.generate(data)
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  owner_id = session[:user_id]
  # TODO: Update database instead
  result = PetShopServer::DogsRepo.adopt(db, {
    'ownerId' => owner_id, 'id' => id, 'shopId' => shop_id })
  # TODO (after you create users table): Attach new dog to logged in user
  JSON.generate(result)
end
