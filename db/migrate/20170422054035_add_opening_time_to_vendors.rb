class AddOpeningTimeToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :opening_time, :time
  end
end
