# メモのメモをするアプリケーション

起動コマンド
```
docker-compose up
```

初回起動コマンド
```
docker-compose build && \
docker-compose run app bundle install && \
docker-compose run app bundle exec rails db:create && \
docker-compose run app bundle exec rails db:migrate && \
docker-compose up
```

mysql接続
```
docker-compose run db mysql -h db -u root
```
