class AddColumnToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :under_category_ids, :string, default: '/'
  end
end
