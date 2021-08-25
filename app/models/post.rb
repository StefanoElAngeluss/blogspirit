class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  has_many_attached :images

  acts_as_votable

  validates :image, attached: true,
            content_type: [:png, :jpg, :jpeg],
            size: { less_than: 100.megabytes },
            dimension: { width: { min: 800, max: 2400 } }
  
  validates :images, 
            limit: { min: 1, max: 3, message: 'Vous avez dépasser le nombre autoriser.' },
            content_type: [:png, :jpg, :jpeg, :mp3],
            attached: { message: 'Plusieurs images doivent être séléctionner.' }
end
