class TwilioNotification
  attr_reader :phone, :message

  def initialize(args={})
    @phone = args[:phone]
    @message = args[:message]
  end

  def send_sms
    client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    sms_message = client.account.messages.create(
      :from => ENV['TWILIO_NUMBER'],
      :to => phone,
      :body => message
    )
  end
end