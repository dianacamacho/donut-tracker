namespace :vendor_notifications do
  task send_specials: :environment do
    Vendor.build_specials_sms
  end

  task send_sold_out: :environment do
    Vendor.build_sold_out_sms
  end
end


