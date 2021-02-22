class Tweet < ApplicationRecord
  belongs_to :user
  
  has_many :likes , dependent: :destroy
  has_many :retweets, class_name: 'Tweet', foreign_key: 'tweet_id' , dependent: :destroy
  validates :content,  presence: true 
  
  def self.tweets_for_me(current_user)
    list_friends = Friend.references(:users).where(user_id: current_user)
    friend = list_friends.map{|e|e.friend_id}
   Tweet.where(user_id: friend)
  end

  def photo_user
   photo = User.references(:tweets).where(id: user_id).pluck :photo
    photo.first
  end
  
  def name_user
    name = User.references(:tweets).where(id: user_id).pluck :name
     name.first
   end

  def perfil_retweet
    tweet = Tweet.references(:tweets).where(id: tweet_id).pluck :user_id
    photo = User.references(:tweets).where(id: tweet).pluck :photo
    photo.first
  end

  def perfil_retweet_name
    tweet = Tweet.references(:tweets).where(id: tweet_id).pluck :user_id
    name = User.references(:tweets).where(id: tweet).pluck :name
    name.first
  end
  
  def perfil_retweet_content
    content = Tweet.references(:tweets).where(id: tweet_id).pluck :content
    content.first
  end

  def all_like
    id_users=  Like.references(:tweets).where(tweet_id: id).pluck :user_id
    users= id_users.map{|user|User.references(:tweets).where(id: user)}
    
  end
end
