# == Schema Information
#
# Table name: memos
#
#  id            :string(20)       not null, primary key
#  body          :text(65535)
#  public_status :integer          default("unpublised"), not null
#  status        :integer          default("incomplete"), not null
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_memos_on_category_id    (category_id)
#  index_memos_on_public_status  (public_status)
#  index_memos_on_status         (status)
#  index_memos_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Memo < ApplicationRecord
  extend RansackSearch
  is_impressionable

  before_create :generate_hex_id
  belongs_to :category, optional: true
  belongs_to :user, optional: true
  has_many :memo_tag_relations, dependent: :destroy
  has_many :tags, through: :memo_tag_relations
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true

  enum status: { incomplete: 0, complete: 1 }
  enum public_status: { unpublised: 0, limited_release: 1, whole_release: 2 }

  scope :title_asc, -> { order title: :asc }

  attribute :category_name, :string

  # ランダム文字列のidを生成
  def generate_hex_id
    self.id = loop do
      hex_id = SecureRandom.hex(10)
      break hex_id unless self.class.exists?(id: hex_id)
    end
  end

  def save_tags(save_tags)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - save_tags
    new_tags = save_tags - current_tags

    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      memo_tag = Tag.find_or_create_by(name: new_name)
      tags << memo_tag
    end
  end

  def merge_category_name(user)
    categories = user.categories.pluck(:id, :name)
    each { |memo| memo.category_name = categories.find { |category| category[0] == memo.category_id }[1] }
  end
end
