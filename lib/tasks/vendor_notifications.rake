namespace :vendor_notifications do
  task send_notification: :environment do
    vendors = Vendor.all
    vendors.each do |vendor|
      vendor.users.each do |user|
        TwilioNotification.new(phone: user.phone, message: vendor.name).send_sms
        puts "message sent"
      end
    end
  end
end
