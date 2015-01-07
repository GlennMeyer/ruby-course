class User < ActiveRecord::Base
  has_many :cats#, foreign_key: 'owner_id'
  has_many :dogs#, foreign_key: 'owner_id'

  validates :username, :presence => true
  validates :username, length: { in: 4..12 }
  validates :password, :presence => true
  validates_format_of :password, with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: "must contain one lowercase letter, one uppercase, and one number"
end

#####  It is best practice to put these other classes in separate files. #####
class Dog < ActiveRecord::Base
  belongs_to :user#, foreign_key: 'owner_id'
  belongs_to :shop
end

class Cat < ActiveRecord::Base
  belongs_to :user#, foreign_key: 'owner_id'
  belongs_to :shop
end

class Shop < ActiveRecord::Base
  has_many :dogs
  has_many :cats
  # has_many :users
end