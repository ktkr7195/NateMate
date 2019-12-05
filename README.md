# NateMate
自然を対象にした画像共有SNSです。

ログインページより、テストユーザーとしてログインできます。

## URL


## 使用技術
- Ruby 2.5.1, Rails 6.0.1
- Docker,Docker-compose
- AWS (VPC,EC2,)
- Capistrano3
- webpacker: SASS,Bootstrap4,JQuery

## 機能一覧
- 管理ユーザー機能(ユーザー、投稿を管理)
- ユーザー登録,ログイン,編集機能(devise)
- 画像記事投稿、削除機能
- 画像プレビュー機能
- 投稿一覧、投稿詳細表示機能
- ページネーション機能
- ユーザー一覧機能
- 検索機能(投稿、ユーザー)
- いいね、フォロー機能(Ajax)
- Dos攻撃など、過剰なアクセスに対する制限機能
