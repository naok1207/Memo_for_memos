class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :memo, null: false, foreign_key: true, type: :string

      t.timestamps
    end
    add_index :bookmarks, [:user_id, :memo_id], unique: true
  end
end
