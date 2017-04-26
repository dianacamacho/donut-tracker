class AddSoldOutSentSpecialsSentToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :sold_out_at, :datetime
    add_column :vendors, :specials_sent_at, :datetime
  end
end
