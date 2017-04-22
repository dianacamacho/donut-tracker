class CreateUserVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :user_vendors do |t|
      t.references :user, foreign_key: true
      t.references :vendor, foreign_key: true
      t.string :hashtag

      t.timestamps
    end
  end
end
