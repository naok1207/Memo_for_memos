class CreateMemoTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :memo_tag_relations do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :memo, null: false, foreign_key: true, type: :string

      t.timestamps
    end
    add_index :memo_tag_relations, [:tag_id, :memo_id], unique: true
  end
end
