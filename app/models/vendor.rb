class Vendor < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :user_vendors, dependent: :destroy
  has_many :users, through: :user_vendors

  def timeline
    call_twitter.timeline
  end

  def today_tweets
    call_twitter.today_tweets
  end

  def sold_out?
    shop_tweets.select{ |tweet| tweet.downcase.include?('sold out')}.any?
  end

  def shop_tweeted_today?
    shop_tweets.any?
  end

  def is_shop_open?
    opening_time <= Time.zone.now
  end

  def shop_tweets
    today_tweets.select {|tweet| tweet.include?(hashtag)}
  end

  def day_specials
    specials = shop_tweets.select{ |tweet| tweet.downcase.include?('special') || tweet.downcase.include?('specials') || tweet.downcase.include?('jelly')}
    result = specials.any?
    result ? specials : ["Specials not available"]
  end

  def call_twitter
    SocialTool.new(twitter_handle: twitter)
  end
end
