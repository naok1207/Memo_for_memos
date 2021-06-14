# == Schema Information
#
# Table name: memos
#
#  id          :string(20)       not null, primary key
#  body        :text(65535)
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_memos_on_category_id  (category_id)
#  index_memos_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Memo < ApplicationRecord
  include RansackSearch

  before_create :generate_hex_id
  belongs_to :category, optional: true
  belongs_to :user, optional: true
  has_many :memo_tag_relations
  has_many :tags, through: :memo_tag_relations

  validates :title, presence: true

  scope :title_asc, -> { order title: :asc }

  # ランダム文字列のidを生成
  def generate_hex_id
    self.id = loop do
      hex_id = SecureRandom.hex(10)
      break hex_id unless self.class.exists?(id: hex_id)
    end
  end

  def save_tags(save_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - save_tags
    new_tags = save_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      memo_tag = Tag.find_or_create_by(name: new_name)
      self.tags << memo_tag
    end
  end
end
