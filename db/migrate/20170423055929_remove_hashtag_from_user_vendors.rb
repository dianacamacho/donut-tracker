class RemoveHashtagFromUserVendors < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_vendors, :hashtag, :string
  end
end
