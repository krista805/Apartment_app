class User < ActiveRecord::Base
  rolify
  has_many :apartments
  after_create :assign_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

 def assign_role
   add_role(:default)
 end

 def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.uid + "@twitter.com"
     user.password = Devise.friendly_token[0,20]
   end
 end


end
# ends user class
