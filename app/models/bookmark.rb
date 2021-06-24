# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  memo_id    :string(255)      not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_memo_id              (memo_id)
#  index_bookmarks_on_user_id              (user_id)
#  index_bookmarks_on_user_id_and_memo_id  (user_id,memo_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (memo_id => memos.id)
#  fk_rails_...  (user_id => users.id)
#
class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :memo

  validates :user_id, presence: true
  validates :memo_id, presence: true
  validates :user_id, uniqueness: { scope: :memo_id }
end
