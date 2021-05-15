class CreateMemos < ActiveRecord::Migration[6.1]
  def change
    # ランダム文字列でidを生成
    create_table :memos, id: false do |t|
      t.string :id, limit: 20, null: false, primary_key: true
      t.string :title, null: false
      t.text :body
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
