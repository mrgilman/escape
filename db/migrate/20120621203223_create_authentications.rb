class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :token
      t.string :secret
      t.integer :user_id
      t.timestamps
    end
  end
end
