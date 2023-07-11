class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @@slot_money = 0
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money
    puts "お金ちょうだい"
    money = gets.chomp.to_i
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return "種類が違いますよ。" unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @@slot_money += money
    puts "投入金額：#{money}円  投入金額合計:#{@@slot_money}円"
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "お釣り : #{@@slot_money}円"
    # 自動販売機に入っているお金を0円に戻す
    @@slot_money = 0
  end
end

# ジュースの管理
class Stock < VendingMachine

  def initialize
    @cola = { name: "コーラ", price: 120, stock: 5 }
    @water = { name: "水", price: 100, stock: 5 }
    @red_bull = { name: "レッドブル", price: 200, stock: 5 }
    # 自販機に入っているドリンク3種類の情報を配列に格納
    @drinks = [@cola, @water, @red_bull]
  end

  # 値段と名前と在庫を取得できる
  def inform_drink_types
    puts "#{@drinks[0][:name]}は#{@drinks[0][:price]}円で在庫は#{@drinks[0][:stock]}本です。"
    puts "#{@drinks[1][:name]}は#{@drinks[1][:price]}円で在庫は#{@drinks[1][:stock]}本です。"
    puts "#{@drinks[2][:name]}は#{@drinks[2][:price]}円で在庫は#{@drinks[2][:stock]}本です。"
  end

  def drink_list
    slot_money = @@slot_money
    if slot_money >= 200
      puts "現在#{@drinks[0][:name]}または#{@drinks[1][:name]}または#{@drinks[2][:name]}が購入可能です。"
    elsif slot_money >= 120
      puts "現在#{@drinks[0][:name]}または#{@drinks[1][:name]}が購入可能です。"
    elsif slot_money >= 100
      puts "現在#{@drinks[1][:name]}が購入可能です。"
    else
      puts "購入不可能です！！お金ちょうだい♡"
    end
  end
end

class Sales < Stock
  def initialize
    super
    @sales = 0
  end

  def purchase
    puts "何を買いますか？"
    puts "1.コーラ 2.水 3.レッドブル"
    choice_drink = gets.to_i - 1
    if enough_money_to_buy_(choice_drink) && enough_stock_to_buy_(choice_drink)
      purchase_process(choice_drink)
      puts "ガチャン"
      puts "#{@drinks[choice_drink][:name]}"
    else
      puts "買えないよ。"
    end
  end

  def enough_money_to_buy_(drink)
    @@slot_money >= @drinks[drink][:price]
  end

  def enough_stock_to_buy_(drink)
    0 < @drinks[drink][:stock]
  end

  def purchase_process(drink)
    @@slot_money -= @drinks[drink][:price]
    @drinks[drink][:stock] -= 1
    @sales += @drinks[drink][:price]
  end

  def current_sales
    puts "現在の売上金額は#{@sales}です。"
  end
end

vm = VendingMachine.new
stock = Stock.new
sales = Sales.new

while true
  puts "---------------------\nどうする？\n---------------------\n1.在庫を見る\n2.お金を入れる\n3.購入可能な商品を見る\n4.商品を購入する\n5.やめる\n---------------------"
  choice = gets.chomp.to_i
  if choice == 1
    sales.inform_drink_types
  elsif choice == 2
    vm.slot_money
  elsif choice == 3
    stock.drink_list
  elsif choice == 4
    sales.purchase
  elsif choice == 5
    vm.return_money
    return
  else
    puts "1~5の数字を入力してください。"
  end
end