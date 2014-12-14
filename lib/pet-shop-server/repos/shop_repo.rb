module PetShopServer
  class ShopsRepo
    def self.all_shops(db)
      db.exec("SELECT * FROM shops;").entries
    end
  end
end
