class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.bigint :user_id, index: true
      t.bigint :friend_id, index: true
      t.boolean :confirmed, default: false

      t.timestamps null: false
    end
  end
end
