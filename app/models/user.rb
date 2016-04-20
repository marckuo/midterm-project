class User < ActiveRecord::Base
  has_secure_password

  has_many :matches
  has_many :reviews

  #validates :first_name
  #validates :last_name
  validates :username, presence: true
  #validates :email
  #validates :phone
  #validates :birthday
  #validates :profile_pic

end