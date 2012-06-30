class AddCommentToFoursquareItems < ActiveRecord::Migration
  def change
    add_column :foursquare_items, :comment, :string
  end
end
