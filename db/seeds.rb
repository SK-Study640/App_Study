# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# db/seeds.rb

# db/seeds.rb
user_names = [
  "John Doe", "Jane Smith", "Robert Johnson", "Emily Davis", "Michael Brown",
  "Jessica Miller", "William Wilson", "Sophia Moore", "David Taylor", "Olivia Anderson",
  "Daniel Thomas", "Isabella Jackson", "James White", "Charlotte Harris", "Benjamin Martin",
  "Mia Thompson", "Lucas Garcia", "Amelia Martinez", "Henry Robinson", "Evelyn Clark"
]

user_names = [
  "John Doe", "Jane Smith", "Robert Johnson", "Emily Davis", "Michael Brown",
  "Jessica Miller", "William Wilson", "Sophia Moore", "David Taylor", "Olivia Anderson",
  "Daniel Thomas", "Isabella Jackson", "James White", "Charlotte Harris", "Benjamin Martin",
  "Mia Thompson", "Lucas Garcia", "Amelia Martinez", "Henry Robinson", "Evelyn Clark"
]

user_names.each do |name|
  # 名前を小文字にし、スペースを取り除いてメールアドレスに使用
  email_name = name.downcase.gsub(" ", ".")

  # 既存のユーザーを確認して、存在しなければ新規作成
  user = User.find_or_create_by(
    email: "#{email_name}@example.com"
  ) do |u|
    u.name = name
    u.password = "password"
    u.password_confirmation = "password"
  end

  # 作成されたユーザーが存在する場合にのみ、結果データを作成
  if user.persisted? # userが正しく保存されたかチェック
    # TypingGame結果をランダムに生成してユーザーに紐付け
    rand(1..5).times do  # 各ユーザーに1〜5件の結果をランダムに生成
      Typing::Result.create(
        time: rand(30..300),  # 30秒から300秒の範囲でランダムなtimeを設定
        user_id: user.id
      )
    end
  else
    puts "User #{name} could not be created: #{user.errors.full_messages.join(", ")}"
  end
end
