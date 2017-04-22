class SocialTool
  attr_accessor :twitter_handle

  def initialize(args={})
    @twitter_handle = args[:twitter]
  end

  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
      config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_SECRET")
    end

    client
  end

  def timeline
    client.user_timeline(twitter_handle)
  end

  def today_tweets
    timeline.select { |tweet| tweet.created_at.today? }.map(&:text)
  end
end