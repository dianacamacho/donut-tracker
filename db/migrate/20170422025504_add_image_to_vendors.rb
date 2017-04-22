class AddImageToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :image, :text
  end
end
