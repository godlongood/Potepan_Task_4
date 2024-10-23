require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

# if文を使用して続きを作成していきましょう。
# 「memo_type」の値（1 or 2）によって処理を分岐させていきましょう。
#1が入力された場合
if memo_type == 1
  loop do # ctrl+cを押すまでループできるように
  puts "新規メモを作成します。拡張子を除いたフォルダ名を入力してください。 ctrl+cで終了します"
  #csvファイルを作成
  folder_name = gets.chomp #改行が入らないように
  puts "メモしたい内容を入力してください"
  Text = gets.chomp #改行が入らないように
  CSV.open("#{folder_name}.csv", 'w') do |f| #csvファイルを作成 新規はwモード
    f << [Text]
  end
  puts "#{folder_name}.csvを作成しました。終了する場合にはctrl+cを押してください" #終了
  end

#2が入力された場合 
elsif memo_type == 2
  puts "既存メモを編集します。拡張子を除いたフォルダ名を入力してください"
    #csvファイルを
    folder_name = gets.chomp #改行が入らないように
    puts "メモの内容は以下の通りです："
    CSV.foreach("#{folder_name}.csv") do |row| #CSVファイルを1行ずつ読み込む
      puts row
    end

    # 編集選択肢を提示
    puts "1 → メモを追記する / 2 → 特定の行を削除する"
    edit_type = gets.to_i
    rows = CSV.read("#{folder_name}.csv") # CSVファイル全体を読み込む
    
    # 編集1が選択された場合
    if edit_type == 1
      puts "追記したい内容を入力してください"
      text = gets.chomp
      CSV.open("#{folder_name}.csv", 'a') do |csv|  # 編集はaモード
        csv << [text]
      end
      puts "-------------------------------------------"
      puts "メモを追記しました。"
      CSV.foreach("#{folder_name}.csv") do |row| #CSVファイルを1行ずつ読み込む
      puts row
      end

    # 編集2が選択された場合
    elsif edit_type == 2
      puts "削除したい行番号を入力してください"
      line_to_delete = gets.to_i

      if line_to_delete.between?(1, rows.size) #1以上、記載されている行数以下であるか確認
        rows.delete_at(line_to_delete - 1) # 指定された行を削除　-1しているのは数え始まりが0のため
        CSV.open("#{folder_name}.csv", 'w') do |csv| # ファイルを上書き
          rows.each { |row| csv << row } #削除後の内容を書き込み
        end
        puts "-------------------------------------------"
        puts "#{line_to_delete} 行目を削除しました。"
        CSV.foreach("#{folder_name}.csv") do |row| #CSVファイルを1行ずつ読み込む
        puts row
        end
      else
        puts "不正な行番号です。"
      end
    end

#1、2以外が入力された場合
else 
  puts "正しい数字を入力してください"
  memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています
end









