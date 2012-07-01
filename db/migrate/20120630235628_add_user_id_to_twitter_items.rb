class AddUserIdToTwitterItems < ActiveRecord::Migration
  def change
    add_column :twitter_items, :user_id, :integer
  end
end
