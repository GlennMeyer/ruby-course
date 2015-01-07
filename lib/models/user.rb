class User < ActiveRecord::Base
  validates :username, :presence => true
  validates :username, length: { in: 4..12 }
  validates :password, :presence => true
  validates_format_of :password, with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/, message: "must contain one lowercase letter, one uppercase, and one number"
end

class Dog < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
end

class Cat < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
end

class Shop < ActiveRecord::Base
  has_many :users
  has_many :dogs
  has_many :cats
end