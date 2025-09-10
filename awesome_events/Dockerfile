# FROMでベースイメージを設定
# 今回はRubyのバージョン3.4をベースイメージとして設定
FROM ruby:3.4
# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev default-mysql-client

# bootstrap を yarn 経由でダウンロードし、 webpacker 経由で使用しようと思ったが、rails7 以降では　webpacker　非推奨のようなので、gem 経由でインストールした。
# 以下は yarn 経由でダウンロードし用とした時の形跡

# yarn の導入パターン１： npm 経由で yarn をインストールする方法
# RUN apt-get install -y build-essential libpq-dev default-mysql-client nodejs npm
# RUN npm install -g yarn

# yarn の導入パターン2： npmを使用しない方法
# デフォルトでインストールされているcmdtestを削除
# RUN apt remove cmdtest
# 古いバージョンのyarnを削除
# RUN apt remove yarn
# サードパーティのリポジトリから最新の yarn　を取得
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#     && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#     && apt-get update && apt-get install -y yarn

# bootstrap を yarn 経由でダウンロードする
# RUN yarn add bootstrap jquery popper.js

# Railsアプリを配置するフォルダをコンテナ内に作成
RUN mkdir /app
# 作成したディレクトリをワークディレクトリとして設定
WORKDIR /app
# ルート配下のGemfileをコンテナ内のRailsアプリを配置場所にコピー
COPY Gemfile /app/Gemfile
# Gemfile.lockも同様にコンテナ内にコピーする
COPY Gemfile.lock /app/Gemfile.lock
# Gemfileの記述を元にbundle installを実行
RUN bundle install --gemfile /app/Gemfile
COPY . /app

# ローカルで作成したentrypoint.shファイル(後で記述)を/usr/bin/へコピー
COPY entrypoint.sh /usr/bin/
# /usr/bin/entrypoint.shに対して実行権限を付与している(chmod +x)
# これによってシェルスクリプトファイルを実行可能にする
RUN chmod +x /usr/bin/entrypoint.sh
# exec形式でデフォルトで実行するコマンドラインの引数としてentrypoint.shを指定
ENTRYPOINT ["entrypoint.sh"]
# ネットワーク上のポートを指定する
EXPOSE 3000

# Railsサーバーを稼働させる
CMD ["bin/dev"]