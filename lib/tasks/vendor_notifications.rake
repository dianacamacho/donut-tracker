namespace :vendor_notifications do
  task send_specials: :environment do
    vendors = Vendor.all
    vendors.each do |vendor|
      if vendor.send_specials_message?
        specials = vendor.day_specials.first
        if vendor.users.any?
          vendor.users.each do |user|
            TwilioNotification.new(phone: user.phone, message: specials).send_sms
            puts "message sent"
          end
        end
      else
        puts "#{vendor.name} has no specials to post"
      end
    end
  end

  task send_sold_out: :environment do
    vendors = Vendor.all
    vendors.each do |vendor|
      if vendor.send_sold_out_message?
        sold_out_message = "I hope you got your donuts, #{vendor.name} just sold out!"
        if vendor.users.any?
          vendor.users.each do |user|
            TwilioNotification.new(phone: user.phone, message: sold_out_message).send_sms
            puts "message sent"
          end
        end
      else 
        puts "#{vendor.name} sold out message not yet sent or already sent"
      end
    end
  end
end


