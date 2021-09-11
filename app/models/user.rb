# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :timeoutable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
         :confirmable, :validatable, :lockable,
         :omniauthable, omniauth_providers: %i[github google_oauth2 facebook]

  attr_accessor :login

  include PublicActivity::Model
  tracked only: [:create, :destroy], owner: :itself

  has_many :posts, dependent: :destroy

  has_many :createur,
           -> { where(roles: { name: :createur }) },
           through: :roles, source: :resource, source_type: :Post

  has_many :designer,
           -> { where(roles: { name: :designer }) },
           through: :roles, source: :resource, source_type: :Post

  has_many :nouvel_utilisateur,
           -> { where(roles: { name: :nouvel_utilisateur }) },
           through: :roles, source: :resource, source_type: :Post

  has_many :invites, class_name: 'User', foreign_key: :invited_by_id

  has_one_attached :avatar
  validates :avatar, attached: true,
                     content_type: %i[png jpg jpeg],
                     size: { less_than: 100.megabytes },
                     dimension: { width: { min: 16, max: 2400 } },
                     if: proc { |imports| !imports.avatar_blob.blank? }

  after_create :assign_default_role
  validate :must_have_a_role, on: :update

  def to_s
    email
  end

  acts_as_voter

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.name # assuming the user model has a name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

  # Ceci est pour utiliser email ou username pour le login voir devise.rb dans initializers
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where('lower(username) = :value OR lower(email) = :value', value: login.downcase).first
    else
      where(conditions.to_hash).first
    end
  end

  private

  def assign_default_role
    add_role(:nouvel_utilisateur) if roles.blank?
  end

  def must_have_a_role
    errors.add(:roles, 'Vous devez avoir au moins 1 rôle de séléctionner') unless roles.any?
  end
end
