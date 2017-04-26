namespace :vendor_notifications do
  task send_specials: :environment do
    vendors = Vendor.all
    vendors.each do |vendor|
      specials = vendor.day_specials.first
      if vendor.users.any?
        vendor.users.each do |user|
          TwilioNotification.new(phone: user.phone, message: specials).send_sms
          puts "message sent"
        end
      end
    end
  end

  task send_sold_out: :environment do
    vendors = Vendor.all
    vendors.each do |vendor|
      if !vendor.sold_out_message_sent?
        sold_out_message = "I hope you got your donuts, #{vendor.name} just sold out!"
        vendor.users.each do |user|
          TwilioNotification.new(phone: user.phone, message: sold_out_message).send_sms
          puts "message sent"
        end
      else 
        puts "#{vendor.name} sold out message not yet sent"
      end
    end
  end
end


