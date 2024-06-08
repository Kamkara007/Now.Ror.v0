class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :public_id, null: false, limit: 16

      t.timestamps
    end

    add_index :posts, :public_id, unique: true
  end
end
