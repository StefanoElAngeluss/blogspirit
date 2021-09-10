# frozen_string_literal: true

class Post < ApplicationRecord
  # rails c puis entrez cette commande:
  # User.find_each { |u| User.reset_counters(u.id, :posts) }
  belongs_to :user, counter_cache: true

  has_one_attached :image
  has_many_attached :images
  # action_text from rails 6
  has_rich_text :content

  has_many :users, through: :roles, class_name: 'User', source: :users
  has_many :nouvel_utilisateur, -> { where(roles: { name: :nouvel_utilisateur }) }, through: :roles, class_name: 'User', source: :users
  has_many :designer, -> { where(roles: { name: :designer }) }, through: :roles, class_name: 'User', source: :users
  has_many :designer, -> { where(roles: { name: :designer }) }, through: :roles, class_name: 'User', source: :users

  enum status: ["Brouillon", "Article publié", "Article banni"], _default: 'Brouillon'
  # enum tags: ["ruby", "wordpress", "php", "html"]
  TAGS = %i[ruby wordpress php html]

  acts_as_votable
  resourcify

  extend FriendlyId
  friendly_id :slug_posts, use: [:slugged, :finders, :history]

  def slug_posts
    [
      :title,
      [:title, :content]
    ]
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  # STATUSES = ['Brouillon', 'Article publié', "Article banni"].freeze
  # validates :status, inclusion: { in: Post::STATUSES }

  # scope :brouillon, -> { where(status: 'Brouillon') }
  # scope :article_publié, -> { where(status: 'Article publié') }
  # scope :article_banni, -> { where(status: 'Article banni') }

  # def article_banni?
  #   status == 'banni'
  # end

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
