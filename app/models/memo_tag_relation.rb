# == Schema Information
#
# Table name: memo_tag_relations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  memo_id    :string(255)      not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_memo_tag_relations_on_memo_id             (memo_id)
#  index_memo_tag_relations_on_tag_id              (tag_id)
#  index_memo_tag_relations_on_tag_id_and_memo_id  (tag_id,memo_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (memo_id => memos.id)
#  fk_rails_...  (tag_id => tags.id)
#
class MemoTagRelation < ApplicationRecord
  belongs_to :tag
  belongs_to :memo
end
