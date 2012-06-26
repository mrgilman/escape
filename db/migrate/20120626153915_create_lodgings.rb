class CreateLodgings < ActiveRecord::Migration
  def change
    create_table :lodgings do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :phone_number
      t.date :start_date
      t.date :end_date
      t.integer :trip_id
      t.timestamps
    end
  end
end
