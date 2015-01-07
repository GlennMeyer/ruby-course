require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/flash'
# require 'rest-client'
# require 'json'
# require './lib/petshop.rb'
require './config/environments.rb'
# require './lib/models/user.rb'

# #
# This is our only html view...
#

configure do
  set :bind, '0.0.0.0'
  enable :sessions
end

get '/' do
  if session[:user_id]

    users = User.all
    users.find_by(id: session[:user_id]).as_json
  end

  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do

  headers['Content-Type'] = 'application/json'

  shops = Shop.all
  shops.to_json
end

post '/signin' do
  params = JSON.parse request.body.read

  users = User.all
  creds = users.find_by(username: params['username']).as_json

  if creds['password'] == params['password']
    headers['Content-Type'] = 'application/json'

    session[:user_id] = creds['id']
    creds.delete('password')

    cats = Cat.all
    cats = cats.where("owner_id = #{session[:user_id]}").as_json

    creds['cats'] = []

    cats.each do |cat|
      creds['cats'] << {shopid: cat['shop_id'], name: cat['name'], imageUrl: cat['image_url'], adopted: true, id: cat['id']}
    end

    dogs = Dog.all
    dogs = dogs.where("owner_id = #{session[:user_id]}").as_json

    creds['dogs'] = []
    dogs.each do |dog|
      creds['dogs'] << {shopid: dog['shop_id'], name: dog['name'], imageUrl: dog['image_url'], adopted: true, id: dog['id']}
    end

    creds.to_json
  else
    status 401
  end
end


#####  Extras #####
get '/signup' do

  erb :signup
end

post '/signup' do

  if params['password'] == params['confirmation']
    user = User.new
    user.username = params['username']
    user.password = params['password']
    saved = user.save
  end

  if saved == false
    flash[:error] = user.errors.to_a.join(".  ")
    redirect to('/signup')
  else
    session[:user_id] = user.id
    redirect to('/')
  end
end

###################

 # # # #
# Cats #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]

  cats = Cat.all
  data = cats.where("shop_id = #{id}").as_json

  data.each do |line|
    line['adopted'] = (line['adopted'] == 't' ? true : false)
  end

  data.to_json
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  owner_id = session[:user_id]

  cats = Cat.all
  cat = cats.find_by( id: id )
  cat.shop_id = shop_id
  cat.owner_id = owner_id
  save = cat.save

  save.to_json
end


 # # # #
# Dogs #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]

  # Dog.connection
  dogs = Dog.all
  data = dogs.where("shop_id = #{id}").as_json
  
  data.each do |line|
    line['adopted'] = (line['adopted'] == 't' ? true : false)
  end

  data.to_json
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  shop_id = params[:shop_id]
  id = params[:id]
  owner_id = session[:user_id]

  dogs = Dog.all
  dog = dogs.find_by( id: id)
  dog.shop_id = shop_id
  dog.owner_id = owner_id
  save = dog.save

  save.to_json
end
