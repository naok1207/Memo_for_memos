# メモのメモをするアプリケーション

起動コマンド
```
docker-compose -f development.yml up -d
```

初回起動コマンド
```
docker-compose -f development.yml build && \
docker-compose -f development.yml run app bundle exec rails db:create && \
docker-compose -f development.yml run app bundle exec rails db:migrate && \
docker-compose -f development.yml up -d
```

mysql接続
```
docker-compose -f development.yml run db mysql -h db -u root
```
