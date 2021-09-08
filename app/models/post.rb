# frozen_string_literal: true

class Post < ApplicationRecord
  # rails c puis entrez cette commande:
  # User.find_each { |u| User.reset_counters(u.id, :posts) }
  belongs_to :user, counter_cache: true

  has_one_attached :image
  has_many_attached :images
  # action_text from rails 6
  has_rich_text :content

  resourcify

  has_many :users, through: :roles, class_name: 'User', source: :users
  has_many :nouvel_utilisateur, -> { where(roles: { name: :nouvel_utilisateur }) }, through: :roles, class_name: 'User', source: :users
  has_many :designer, -> { where(roles: { name: :designer }) }, through: :roles, class_name: 'User', source: :users
  has_many :designer, -> { where(roles: { name: :designer }) }, through: :roles, class_name: 'User', source: :users

  STATUSES = ['En construction', '|', 'Article publié !!!', '|', "L'article n'est pas publier"].freeze

  acts_as_votable

  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 100.megabytes },
                    dimension: { width: { min: 800, max: 2400 } }

  validates :images,
            limit: { min: 1, max: 3, message: 'Vous avez dépasser le nombre autoriser.' },
            content_type: %i[png jpg jpeg mp3],
            attached: { message: 'Plusieurs images doivent être séléctionner.' }

  validates :status, presence: true
end
