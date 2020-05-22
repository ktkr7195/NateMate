# NateMate
現在ポートフォリオとして作成中の自然SNSです  
投稿した画像のExifまたは住所から位置情報を取得し、  
ユーザー同士で共有、マイマップ機能で一括管理ができます  

## URL
- https://natemate.com  
ログインページからおためしログインをクリックで、ゲストアカウントとしてログインできます  
ゲストユーザーのみプロフィール情報を編集不可に設定しています  

## 使用技術
- Ruby 2.5.1, Rails 6.0.1
- webpacker: scss,Bootstrap4,jQuery
- Docker,Docker-compose
- nginx,puma
- AWS (VPC,EC2,RDS for MySQL,S3,SES,Route53,ACM,ALB)
- Terraform
- Circle CI/CD(Capistrano3)
- Rspec
- GoogleMapsAPI,GeolocationAPI

## 機能一覧
- 管理ユーザー機能(ユーザー、投稿を削除)
- ユーザー登録,ログイン,編集機能(devise)
- 画像記事投稿、削除機能
- 記事へのコメント投稿、削除機能(Ajax)
- 投稿、プロフィール画像プレビュー機能
- 画像のExif情報又はgeocodingによる緯度経度取得,GoogleMapsAPIで表示
- ユーザー毎に全投稿の位置をマーカで表示するマップ機能
- 現在位置取得機能
- 投稿一覧、投稿詳細表示機能
- ページネーション機能(Ajax)
- いいね、フォロー機能(Ajax)
- ユーザー一覧、フォローフォロワー一覧、投稿をいいねしたユーザー一覧機能
- 検索機能(投稿、ユーザー)
- 単体spec、システムspec
