# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name)
#
class Tag < ApplicationRecord
  has_many :memo_tag_relations
  has_many :memos, through: :memo_tag_relations
end
