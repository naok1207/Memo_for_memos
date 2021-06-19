module RansackSearch
  # ransackを用いた複数検索
  # matcher : ransackのmatcher
  # key_word : 検索する値
  # grouping_hash : 検索文字を分割してmatcherを含めてhash化
  def multiple_search(matcher, key_word)
    key_words = key_word.split(/[\p{blank}\s]+/)
    grouping_hash = key_words.each_with_index.reduce({}){|hash, (word, index)| hash.merge(index.to_s => { matcher => word })}
    self.ransack({combinator: 'and', groupings: grouping_hash}).result
  end
end
