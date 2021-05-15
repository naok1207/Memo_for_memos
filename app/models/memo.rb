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
  before_create :generate_hex_id
  belongs_to :category, optional: true
  belongs_to :user, optional: true

  scope :title_asc, -> { order title: :asc }

  # ランダム文字列のidを生成
  def generate_hex_id
    self.id = loop do
      hex_id = SecureRandom.hex(10)
      break hex_id unless self.class.exists?(id: hex_id)
    end
  end
end
