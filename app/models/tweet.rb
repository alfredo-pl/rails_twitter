class Tweet < ApplicationRecord
  belongs_to :user
  #belongs_to :tweet
  #has_many :tweets
  validates :content, presence: true
end
