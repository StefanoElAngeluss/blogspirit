class User < ApplicationRecord

	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
				 :validatable, :omniauthable, omniauth_providers: [:github, :google_oauth2, :twitter, :facebook]
  
  attr_accessor :login

  def to_s
    email
  end

	# def self.from_omniauth(auth)
  # 	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #   	user.email = auth.info.email
  #   	user.password = Devise.friendly_token[0, 20]
    	# user.name = auth.info.name   # assuming the user model has a name
    	# user.image = auth.info.image # assuming the user model has an image
    	# If you are using confirmable and the provider(s) you use validate emails,
    	# uncomment the line below to skip the confirmation emails.
  #   	user.skip_confirmation!
  # 	end
	# end

	# Ceci est pour utiliser l'email ou l'username pour le login voir devise.rb dans initializers
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
    else
      where(conditions.to_hash).first
    end
  end

	# Google Omniauth Oauth2
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
        user = User.create(
          username: data['name'],
          email: data['email'],
          password: Devise.friendly_token[0,20]
        )
    end
    user.provider = access_token.provider
    user.uid = access_token.uid
    unless user.name.present?
      user.name = access_token.info.name
    end
		unless user.image.present?
    	user.image = access_token.info.image
		end
    user.save

    user.confirmed_at = Time.now # Autoconfirm User form omniauth
    user
  end
	
end
