class CreateInstagramItems < ActiveRecord::Migration
  def change
    create_table :instagram_items do |t|
      t.string :instagram_id
      t.string :url
      t.string :location
      t.string :caption
      t.datetime :timestamp
      t.integer :utc_offset
      t.integer :user_id
      t.timestamps
    end
  end
end
