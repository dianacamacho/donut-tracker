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
    result = today_tweets.select {|tweet| tweet.include?(hashtag) && tweet.downcase.include?('sold out')}.any?
    result ? true : false
  end

  def location_tweeted_today?
    result = today_tweets.select {|tweet| tweet.include?(hashtag)}.any?
    result ? true : false
  end

  def is_location_open?
    opening_time <= Time.zone.now
  end

  def day_specials
    specials = today_tweets.select {|tweet| tweet.include?(hashtag) && (tweet.downcase.include?('special') || tweet.downcase.include?('specials') || tweet.downcase.include?('jelly')) }
    result = specials.any?
    result ? specials : ["Specials not available"]
  end

  def call_twitter
    SocialTool.new(twitter_handle: twitter)
  end
end
