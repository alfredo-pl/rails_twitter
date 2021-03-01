class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, dependent: :destroy
  validates :name, :photo, presence: true

  def friends_count
    Friend.references(:users).where(user_id: id).count
  end

  def tweet_count
    Tweet.references(:users).where(user_id: id).count
  end

  def like_count
    Like.references(:users).where(user_id: id).count
  end

  def retweet_count
    t = Tweet.references(:users).where(user_id: id)
    r = t.where(tweet_id: nil).count
    t.count - r
  end
end
