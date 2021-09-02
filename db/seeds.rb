# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  user = User.find_or_create_by(username: "hoge") do |user|
    user.email = "hoge@hoge.hoge"
    user.password = "hogehoge"
    user.password_confirmation = "hogehoge"
  end

  10.times do |i|
    new_category = user.categories.create(name: "category-#{i}", parent_id: nil)
    # puts 'create category ' + new_category.name
    5.times do |j|
      memo = new_category.memos.new(title: "memo-#{i}-#{j}", body: nil, user_id: user.id)
      memo.save
      # puts 'create memo '+ memo.title
    end
  end

  user.categories.main.each do |category|
    10.times do |i|
      new_category = category.children.create(name: "#{category.name}-#{i}", user_id: user.id, parent_id: category.id)
      # puts 'create category ' + new_category.name
      5.times do |j|
        memo = new_category.memos.create(title: "memo-#{j}", body: "memo-#{j} detail body")
        # puts 'create memo ' + memo.title
    end
    end
  end
  puts "created development default user\n"
else

end

# 管理者ユーザ生成
username = Faker::JapaneseMedia::SwordArtOnline.game_name
email = username + "@example.com"
password = 
  if Rails.env.production?
    SecureRandom.hex(10)
  else
    'hogehoge'
  end
puts "admin_password: " + password;

User.create!(
  username: username,
  email: email,
  password: password,
  password_confirmation: password,
  role: 1
)