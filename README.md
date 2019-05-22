# README

## テーブル構成

![ER図](https://user-images.githubusercontent.com/46367836/57760124-0bb71d00-7736-11e9-82b5-c0df521b815d.png)

## Heroku へのデプロイ方法

1.アセットファイルをプリコンパイル

下記コマンドを実行し、圧縮したアセットファイルを作成します。

`$ rails assets:precompile RAILS_ENV=production`

2.Heroku にログイン

heroku login コマンドを実行してログインします。

`$ heroku login`

3.コミット

git commit コマンドを実行して、コミットをします。

`$ git add -A`
`$ git commit -m "Herokuデプロイ"`

4.Heroku に新しいアプリケーションを作成します。

デプロイしたいアプリのカレントディレクトリに位置していることを確認し、下記コマンドを実行して Heroku に新しいアプリケーションを作成します。

`$ heroku create`

5.Heroku にデプロイします。

`$ git push heroku master`

6.データベースの移行

Heroku データベースの作成は自動で行われますが、マイグレーション（テーブル作成）は手動で実行する必要があります。

`$ heroku run rails db:migrate`

## バージョン

Ruby 2.6.2

Ruby on Rails 5.2.3

PostgreSQL 11.2
