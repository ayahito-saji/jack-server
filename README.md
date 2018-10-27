# jack運営のためのサーバー
* Ruby 2.4
* Rails 5.1 〜

## セットアップ
git cloneして，プロジェクタフォルダ内で

データベースをセットアップ
```
$ rails db:migrate
```
サーバーを立てる
```
$ rails server
```

#### データベース登録
サーバーを立てた後，次のURLにアクセスして，データベースを作成する

メンバーをslack経由で自動で登録する
```
localhost:3000/api/members/seed
```
2018年度の通常活動を登録する
```
localhost:3000/api/events/seed
```