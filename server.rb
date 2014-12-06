require 'sinatra'
require './lib/library_plus'
require 'sinatra/reloader'

set :bind, '0.0.0.0' # This is needed for Vagrant

get '/' do
  erb :index
end

get '/users' do
  db = Library.create_db_connection('library_test')
  @users = Library::UserRepo.all(db)
  erb :"users/index"
end

post '/users' do
  db = Library.create_db_connection('library_test')
  Library::UserRepo.save(db, {'name' => params[:user_name]})
  redirect to('/users')
end

get '/books' do
  db = Library.create_db_connection('library_test')
  @books = Library::BookRepo.all(db)
  erb :"books/index"
end

post '/books' do
  db = Library.create_db_connection('library_test')
  Library::BookRepo.save(db, {'title' => params[:book_title], 'author' => params[:book_author]})
  books = Library::BookRepo.all(db)
  Library::BookRepo.checkout(db, {'book_id' => books.last['id'], 'status' => 'available'})
  redirect to('/books')
end

get '/books/:id' do
  db = Library.create_db_connection('library_test')
  @users = Library::UserRepo.all(db)
  @book = Library::BookRepo.find(db, params[:id])
  @id = params[:id]
  erb :"books/book"
end

post '/books/:id/checkout' do
  db = Library.create_db_connection('library_test')

  Library::BookRepo.checkout(db, {'user_id' => params[:user_id], 'book_id' => params[:id]})
  redirect to("/books/#{params[:id]}/status")
end

get '/status' do
  db = Library.create_db_connection('library_test')
  @status = Library::BookRepo.status(db, params[:id])
  erb :"books/statusall"
end

get '/books/:id/status' do
  db = Library.create_db_connection('library_test')
  @status = Library::BookRepo.status(db)
  # @book = Library::BookRepo.find(db, params[:id])
  # @user = Library::UserRepo.find(db, @status.first['user_id'])
  erb :"books/status"
end

# get '/checkout' do
#   db = Library.create_db_connection('library_test')
#   @books = Library::BookRepo.all(db)
#   erb :"books/checkout"
# end

# post '/checkout' do
#   db = Library.create_db_connection('library_test')
#   Library::BookRepo.checkout(db, {'user_id' => params[:book_user_id], 'book_id' => params[:book_id]})
#   redirect to('/checkout')
# end

# post '/bookstatus' do
#   db = Library.create_db_connection('library_test')
#   # redirect to('/bookstatus')
#   erb :"books/status"
# end