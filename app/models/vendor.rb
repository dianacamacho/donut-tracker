class Vendor < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :user_vendors, dependent: :destroy
  has_many :users, through: :user_vendors

  def today_tweets
    SocialTool.new(twitter_handle: twitter).today_tweets
  end

  def sold_out?
    result = today_tweets.select {|tweet| tweet.downcase.include?(hashtag) && tweet.downcase.include?('sold out') }
    result ? true : false
  end
end
