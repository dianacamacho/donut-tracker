class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :twitter
      t.string :hashtag

      t.timestamps
    end
  end
end
