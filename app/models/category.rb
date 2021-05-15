# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#  user_id    :bigint           not null
#
# Indexes
#
#  index_categories_on_name_and_user_id  (name,user_id) UNIQUE
#  index_categories_on_parent_id         (parent_id)
#  index_categories_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Category < ApplicationRecord
  belongs_to :user
  # 上位階層のカテゴリ
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id', optional: true
  # 下位階層のカテゴリ
  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :user_id }

  has_many :memos, dependent: :nullify

  scope :name_asc, -> { order name: :asc }
  # 最上位階層のカテゴリの絞り込み
  scope :main,   -> { where parent_id: nil }

  def to_param
    name
  end

  # 子要素の全てのデータを残さずに削除する
  def children_destroy_all
    self.children.each do |category|
      category.children_destroy_all
    end
    self.children.destroy_all
    self.memos.destroy_all
  end
end
