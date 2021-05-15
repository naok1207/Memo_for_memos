class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :parent_id

      t.timestamps
    end
    add_index :categories, [:name, :user_id], unique: true
    add_index :categories, :parent_id
  end
end
