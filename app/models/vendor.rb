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
    shop_tweets.select{|tweet| tweet.downcase.include?('sold out')}.any?
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
    specials = shop_tweets.select{|tweet| !tweet.downcase.include?('sold out')}
    result = specials.any?
    result ? specials : ["Specials not available"]
  end

  def call_twitter
    SocialTool.new(twitter_handle: twitter)
  end

  def send_sold_out_message?
    if sold_out?
      if !sold_out_at.blank? && sold_out_at.today?
        false
      else
        update(sold_out_at: DateTime.now)
        true
      end
    else
      false
    end
  end

  def send_specials_message?
    if !day_specials.include?("Specials not available")
      if !specials_sent_at.blank? && specials_sent_at.today?
        false
      else
        update(specials_sent_at: DateTime.now)
        true
      end
    else
      false
    end
  end

  def self.build_specials_sms
    Vendor.all.each do |vendor|
      if vendor.send_specials_message?
        specials = vendor.day_specials.first
        vendor.send_sms(specials)
      end
    end
  end

  def self.build_sold_out_sms
    Vendor.all.each do |vendor|
      if vendor.send_sold_out_message?
        sold_out_message = "I hope you got your donuts, #{vendor.name} just sold out!"
        vendor.send_sms(sold_out_message)
      end
    end
  end

  def user_phone_numbers
    users.pluck(:phone)
  end

  def send_sms(message_body)
    phone_numbers = self.user_phone_numbers
    if phone_numbers.any?
      phone_numbers.each do |phone_number|
        TwilioNotification.new(phone: phone_number, message: message_body).send_sms
        puts "#{message_body} sent"
      end
    end
  end
end
