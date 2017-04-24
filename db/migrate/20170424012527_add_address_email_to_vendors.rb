class AddAddressEmailToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :address, :string
    add_column :vendors, :email, :string
  end
end
