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

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @@slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    puts "お金ちょうだい"
    money = gets.chomp.to_i
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    @slot_money += money
    puts "投入金額：#{@slot_money}円"
    return false unless MONEY.include?(money)

    # 自動販売機にお金を入れる
    @@slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @@slot_money
    # 自動販売機に入っているお金を0円に戻す
    @@slot_money = 0
  end
end

# ジュースの管理
class Stock < VendingMachine
  # コーラの値段は1本120円
  # DEFAULT_NAME = "cola"
  # DEFAULT_PRICE = 120
  # # 初期状態でコーラを5本格納している
  # DEFAULT_NUMBER = 5
  # #読み取り用のメソッドを定義
  # attr_accessor :name, :price, :number

  # def initialize(name = DEFAULT_NAME, price = DEFAULT_PRICE, number = DEFAULT_NUMBER)
    # @name = name
    # @price = price
    # @number = number
  # end
  def initialize
    @cola = {name: "コーラ", price: 120, stock: 5 } #追記
    @water = {name: "水", price: 100, stock: 5 } #追記
    @red_bull = {name: "レッドブル",price: 200, stock: 5 } #追記
    # 自販機に入っているドリンク3種類の情報を配列に格納
    @drinks = [@cola, @water, @red_bull] #追記
  end

  # 値段と名前と在庫を取得できる
  # def current_drink
  #   puts "#{@name}は#{@price}円で在庫は#{@number}本です。"
  # end
  def inform_drink_types
    puts "#{@drinks[0][:name]}は#{@drinks[0][:price]}円で在庫は#{@drinks[0][:stock]}本です。"
    puts "#{@drinks[1][:name]}は#{@drinks[1][:price]}円で在庫は#{@drinks[1][:stock]}本です。"
    puts   "#{@drinks[2][:name]}は#{@drinks[2][:price]}円で在庫は#{@drinks[2][:stock]}本です。"
  end

  # drinks = []
  # cola = { name: "コーラ", price: 120, number: 5 }
  # redbull = { name: "レットブル", price: 200, number: 5 }
  # water = { name: "水", price: 100, number: 5 }

  # drinks << cola
  # drinks << redbull
  # drinks << water

  def drink_list
    case @@slot_money
    when @@slot_money >= 200
      puts "現在#{drinks[0][:name]}または#{drinks[1][:name]}または#{drinks[2][:name]}が購入可能です。"
    when @@slot_money >= 120
      puts "現在#{drinks[0][:name]}または#{drinks[2][:name]}が購入可能です。"
    when @@slot_money >= 100
      puts "現在#{drinks[2][:name]}が購入可能です。"
    else
      puts "購入不可能です！！お金ください♡"
    end
  end
end

class Sales < Stock
  def initialize
    @sales = 0
  end

  def purchase(money)
    if @@slot_money > @price
      @@slot_money -= @price
      @number -= 1
      @sales += @price
      return_money
    end
  end

  def current_sales
    puts "現在の売上金額は#{@sales}です。"
  end

  def stocks
    puts "現在#{@name}は残り#{@number}本です。"
  end
end

vm = VendingMachine.new
vm.slot_money(500)
stock = Stock.new
stock.drink_list

