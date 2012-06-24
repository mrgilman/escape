class CreateFoursquareItems < ActiveRecord::Migration
  def change
    create_table :foursquare_items do |t|
      t.string :foursquare_id
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :user_id
      t.timestamps
    end
  end
end
