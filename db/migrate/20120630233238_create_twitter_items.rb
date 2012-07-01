class CreateTwitterItems < ActiveRecord::Migration
  def change
    create_table :twitter_items do |t|
      t.string :twitter_id
      t.string :text
      t.datetime :timestamp
      t.integer :utc_offset
      t.timestamps
    end
  end
end
