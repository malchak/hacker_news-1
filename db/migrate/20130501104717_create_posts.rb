class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.references :user
      t.timestamps
    end
    add_index :posts, [:user_id] #optimizes line 6
  end
end
