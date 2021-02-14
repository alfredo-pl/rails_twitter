class Tweet < ApplicationRecord
  belongs_to :user
  #belongs_to :tweet
  has_many :likes
  validates :content, presence: true

  def photo_user
   photo = User.references(:tweets).where(id: user_id).pluck :photo
    photo.first
  end


end
