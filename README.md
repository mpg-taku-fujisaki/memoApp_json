# memoApp_json
dev memoApp with json file

#立ち上げ方法
ローカルにダウンロード後、ルートディレクトリで、以下のコマンドを実行

＄bundle exec ruby app.rb  
ブラウザでlocalhost:****にアクセス


# 要件チェック項目
✅PRGパターンで実装されていること
✅RESTに倣ったURIになっていること
✅レビュアーが、ローカルでアプリケーションを立ち上げるための手順書がREADMEに記載されていること
✅Bundlerを使って必要なGemをインストールする手順になっていること
✅ファイルに保存されていること（DBを使わないこと）
✅追加はPOSTメソッド、編集はPATCHメソッド、削除はDELETEメソッドで実装すること
XSS対策できていること
rubocop-fjordのルールでのrubocopを通過していること
ERB LInt のチェックをパスできていること
