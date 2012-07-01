class AddUtcOffsetToFoursquareItems < ActiveRecord::Migration
  def change
    add_column :foursquare_items, :utc_offset, :integer
  end
end
