# NateMate
現在ポートフォリオとして作成中です。

## URL
- https://natemate.com
- ログインページからおためしログインをクリックで、ゲストアカウントとしてログインできます。
- ゲストユーザーのみプロフィール情報が編集不可になっています。

## 使用技術
- Ruby 2.5.1, Rails 6.0.1
- webpacker: SASS,Bootstrap4,JQuery
- Docker,Docker-compose
- nginx,puma
- AWS (VPC,EC2,RDS for MySQL,S3,SES,Route53,ACM,ALB)
- Terraform
- Circle CI/CD(Capistrano3)
- Rspec
- GoogleMapsAPI

## 機能一覧
- 管理ユーザー機能(ユーザー、投稿を管理)
- ユーザー登録,ログイン,編集機能(devise)
- 画像記事投稿、削除機能
- 画像プレビュー機能(Ajax)
- 画像のExif情報から緯度経度を取得,GoogleMapsAPIで表示
- 投稿一覧、投稿詳細表示機能
- ページネーション機能
- いいね、フォロー機能(Ajax)
- ユーザー一覧、フォローフォロワー一覧、投稿をいいねしたユーザー一覧機能
- 検索機能(投稿、ユーザー)
- 単体テスト、統合テスト機能(Rspec)
