class User < ApplicationRecord
	devise :omniauthable, omniauth_providers: %i[google_oauth2]
  has_many :posts

	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
				 :validatable, :omniauthable, omniauth_providers: [:github, :google_oauth2, :facebook]
  
  attr_accessor :login

  def to_s
    email
  end

  acts_as_voter

	def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    	user.email = auth.info.email
    	user.password = Devise.friendly_token[0, 20]
    	user.username = auth.info.name   # assuming the user model has a name
    	# user.image = auth.info.image # assuming the user model has an image
    	# If you are using confirmable and the provider(s) you use validate emails,
    	# uncomment the line below to skip the confirmation emails.
  #   	user.skip_confirmation!
  	end
	end

	# Ceci est pour utiliser email ou username pour le login voir devise.rb dans initializers
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
    else
      where(conditions.to_hash).first
    end
  end

end
