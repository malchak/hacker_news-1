class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user
      t.references :post
      t.timestamps
    end
    add_index :comments, [:user_id, :post_id] #optimizes line 6 and 7
  end
end
