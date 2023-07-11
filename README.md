## こだわりの実装ポイント

- コードを実行すれば購入フローが回るようにしました！
- クラス変数を使ってみました！
- 購入した際に、実際に自販機から出てくる雰囲気を作ってみました！
  <br>

## 聞いてみたい事・リファクタしてもらいたい箇所など

- 各クラスをインスタンス化している部分（106-127 行目）が、どのクラスにも属していません。このコードは問題があるでしょうか。（神田）
- メソッドもファットにならない方が良いでしょうか？（神田）
- クラスの継承の必要性についての認識が曖昧です。教えてください（村田）
- 継承するならどういうケースか知りたいです（近野）
- リファクタリング:もし継承せず(@@slot_money を使わず)別のクラスからメソッドを引き継ぐならどのようにすればいいですか?（近野）
- クラスの分け方を教えてください。（小野）
- 87−93行目のような1行だけのメソッドを作る意味はありますか？(小野)
- 開発する際にクラス分けを考えることと、完成させることどちらを優先させるべきなのでしょうか？（浅沼）
- （現役エンジニアの方だったら）今回のワークの完成にかかる時間を教えてください。（近藤）
- 安全性を高めるために、現場でカプセル化をどのように使用しているのでしょうか？（出島）
