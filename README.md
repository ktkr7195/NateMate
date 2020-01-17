# NateMate
道端の石ころや遠くの星にも、必ず名前やエピソードがあります。
NateMateは、
普段目にしても気に止めない。見たり聞いたことはあっても詳しくは知らない。
そんな自然の新たな発見や感動、知識を共有するSNSです。

## URL
- https://natemate.com
ログインページからおためしログインをクリックで、ゲストアカウントとしてログインできます。

## 使用技術
- Ruby 2.5.1, Rails 6.0.1
- webpacker: Sass,Bootstrap4,JQuery
- Docker,Docker-compose
- AWS (VPC,RDSforMySQL,S3,SES,Route53,ACM,ALB)
- Circle CI/CD(Capistrano3)
- Rspec
- GoogleMapsAPI

## 機能一覧
- 管理ユーザー機能(ユーザー、投稿を管理)
- ユーザー登録,ログイン,編集機能(devise)
- 画像記事投稿、削除機能
- 画像プレビュー機能(Ajax)
- 画像のExif情報から緯度経度を取得,GoogleMapsAPIで表示(Ajax)
- 投稿一覧、投稿詳細表示機能
- ページネーション機能
- ユーザー一覧機能
- 検索機能(投稿、ユーザー)
- いいね、フォロー機能(Ajax)
- 過剰なアクセスに対する制限機能
