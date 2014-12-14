module PetShopServer
  class UsersRepo
    def self.authenticate(db, username)
      db.exec("SELECT * FROM users WHERE username = $1", [username]).entries.first
    end

    def self.user_data(db, user_id)
      creds = db.exec('SELECT * FROM users WHERE id = $1', [user_id]).entries.first

      cats_array = []
      dogs_array = []

      cats_sql = PetShopServer::CatsRepo.by_owner_id(db, creds['id'])
      dogs_sql = PetShopServer::DogsRepo.by_owner_id(db, creds['id'])

      cats_sql.each do |cat|
        cats_array << { shopId: cat['shopId'], name: cat['name'], imageUrl: cat['imageUrl'], adopted: cat['adopted'], id: cat['id']}
      end

      dogs_sql.each do |dog|
        dogs_array << { shopId: dog['shopId'], name: dog['name'], imageUrl: dog['imageUrl'], adopted: dog['adopted'], id: dog['id']}
      end

      creds[:cats] = cats_array
      creds[:dogs] = dogs_array

      creds
    end
  end
end
