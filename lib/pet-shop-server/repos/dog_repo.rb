module PetShopServer
  class DogsRepo
    def self.adopt(db, dog_data)
      result = db.exec('UPDATE dogs SET adopted = $1, "ownerId" = $2 WHERE id = $3 AND "shopId" = $4 RETURNING *', ['true', dog_data['ownerId'], dog_data['id'], dog_data['shopId']])
      result.entries.first
    end
    
    def self.all_dogs(db, shop_id)
      db.exec('SELECT * FROM dogs WHERE "shopId" = $1', [shop_id]).entries
    end

    def self.by_owner_id(db, owner_id)
      db.exec('SELECT * FROM dogs WHERE "ownerId" = $1', [owner_id]).entries
    end
  end
end