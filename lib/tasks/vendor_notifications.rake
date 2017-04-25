namespace :vendor_notifications do
  desc "TODO"
  task :specials_notification, [:phone, :message] => :environment do |_t, args|
    TwilioNotification.new(phone: args[:phone], message: args[:message]).send_sms
    puts "message sent"
  end

  desc "TODO"
  task sold_out_notification: :environment do
    puts "HELLO TESTING SOLD OUT"
  end
end
