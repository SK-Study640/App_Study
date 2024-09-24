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


# db/seeds.rb

typing_sentences = [
  "The quick brown fox jumps over the lazy dog.",
  "Hello, world!",
  "Ruby on Rails is a great framework.",
  "Learning to type is fun.",
  "Speed typing improves with practice.",
  "Code fast, debug faster.",
  "Typing is an essential skill.",
  "I love programming challenges.",
  "Keep your fingers on the home row.",
  "Let's learn to type faster.",
  "She sells seashells by the seashore.",
  "Peter Piper picked a peck of pickled peppers.",
  "A quick movement of the enemy will jeopardize six gunboats.",
  "Pack my box with five dozen liquor jugs.",
  "The five boxing wizards jump quickly.",
  "Typing games are enjoyable.",
  "Coding is like solving puzzles.",
  "Practice makes perfect.",
  "The more you type, the faster you get.",
  "Rails migrations are very useful.",
  "Always remember to save your work.",
  "Consistency is key to mastering typing.",
  "Typing fast is an asset in programming.",
  "Developers often need to type quickly.",
  "Correct typing technique is important.",
  "Time flies when you type quickly.",
  "Errors are part of learning to type.",
  "Think before you type.",
  "Fast typing requires practice and patience.",
  "Programming languages require accuracy.",
  "Focus on accuracy first, speed will follow.",
  "Don't rush; type with purpose.",
  "Clean code is as important as fast typing.",
  "The quick brown fox is a famous pangram.",
  "Home row typing improves speed.",
  "Typing tests are great for measuring progress.",
  "Relax your hands while typing.",
  "Take breaks to avoid fatigue.",
  "Use all your fingers to type.",
  "Never look at your keyboard while typing.",
  "Speed comes with consistent practice.",
  "Remember to maintain good posture while typing.",
  "Type softly and swiftly.",
  "Touch typing is a valuable skill.",
  "Programming and typing go hand in hand.",
  "Type now, fix later.",
  "Small improvements lead to big gains.",
  "Typing accurately is better than typing fast.",
  "Break your bad typing habits.",
  "Typing games are both fun and educational.",
  "Master touch typing with patience.",
  "Fast typists stay calm under pressure.",
  "Typing shortcuts save time.",
  "Develop muscle memory for typing.",
  "A clean keyboard helps with typing speed.",
  "Every keystroke counts.",
  "Good typing posture prevents injury.",
  "Fast typing is like a reflex.",
  "Focus on rhythm and flow while typing.",
  "Typing in complete sentences is great practice.",
  "Programming is 90% typing and 10% problem solving.",
  "Type with precision, not speed.",
  "Take a typing test every week.",
  "Keep practicing to improve your speed.",
  "Errors happen, just keep typing.",
  "Fast typing is a competitive skill.",
  "Type with confidence and precision.",
  "Consistency is the key to fast typing.",
  "Avoid unnecessary keystrokes.",
  "Typing is a skill that anyone can learn.",
  "Practice typing every day for better results.",
  "Stay focused while typing.",
  "Typing without looking takes practice.",
  "Slow down to reduce typing errors.",
  "Fast fingers make a good typist.",
  "Patience is required for improving typing speed.",
  "Typing games make learning fun.",
  "Never stop improving your typing skills.",
  "The faster you type, the more efficient you become.",
  "Keep your hands relaxed while typing.",
  "Typing in code requires focus and speed.",
  "The art of fast typing is in the technique.",
  "Make every keystroke count.",
  "Accuracy first, speed second.",
  "Learn to type without looking at your hands.",
  "Typing is like playing an instrument.",
  "The better you type, the more productive you are.",
  "Speed and accuracy are the goals of a good typist.",
  "Type in a steady rhythm for best results.",
  "Speed typing is a valuable skill in any profession.",
  "Type faster, think clearer.",
  "Your typing speed is your productivity.",
  "Type every day to stay sharp.",
  "Type confidently, type accurately.",
  "A good typist never stops improving.",
  "Fast typing opens the door to better coding.",
  "Type now, edit later.",
  "Your speed will improve with time.",
  "Typing quickly is the result of good habits.",
  "Set goals to increase your typing speed.",
  "The more you type, the more you learn."
]

# データベースにインサート
typing_sentences.each do |sentence|
  Typing::Sentence.create(content: sentence)
end

