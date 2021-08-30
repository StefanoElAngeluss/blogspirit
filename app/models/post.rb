class Post < ApplicationRecord
  # rails c puis entrez cette commande:
  # User.find_each { |u| User.reset_counters(u.id, :posts) }
  belongs_to :user, counter_cache: true

  has_one_attached :image
  has_many_attached :images
  # action_text from rails 6
  has_rich_text :content

  STATUSES = ["En construction", "|", "Article publié !!!", "|", "L'article n'est pas publier"]

  acts_as_votable

  validates :image, attached: true,
            content_type: [:png, :jpg, :jpeg],
            size: { less_than: 100.megabytes },
            dimension: { width: { min: 800, max: 2400 } }
  
  validates :images, 
            limit: { min: 1, max: 3, message: 'Vous avez dépasser le nombre autoriser.' },
            content_type: [:png, :jpg, :jpeg, :mp3],
            attached: { message: 'Plusieurs images doivent être séléctionner.' }

  validates :status, presence: true
end
