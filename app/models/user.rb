class User < ApplicationRecord
    extend Devise::Models
  
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable,
            :lockable, :timeoutable #, :trackable,:confirmable

    include DeviseTokenAuth::Concerns::User
end
