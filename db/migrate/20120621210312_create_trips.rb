class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :display_name
      t.string :primary_location
      t.date :start_date
      t.date :end_date
      t.integer :user_id
      t.timestamps
    end
  end
end
