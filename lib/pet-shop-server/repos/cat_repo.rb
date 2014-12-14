module PetShopServer
  class CatsRepo
    def self.adopt(db, cat_data)
      result = db.exec('UPDATE cats SET adopted = $1, "ownerId" = $2 WHERE id = $3 AND "shopId" = $4 RETURNING *', ['true', cat_data['ownerId'], cat_data['id'], cat_data['shopId']])
      result.entries.first
    end
    
    def self.all_cats(db, shop_id)
      db.exec('SELECT * FROM cats WHERE "shopId"= $1', [shop_id]).entries
    end

    def self.by_owner_id(db, owner_id)
      db.exec('SELECT * FROM cats WHERE "ownerId" = $1', [owner_id]).entries
    end
  end
end