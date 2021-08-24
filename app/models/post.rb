class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
    attachable.variant :medium, resize: "300x250"
  end

  acts_as_votable

end
