#!/bin/bash

#Собираю новый образ mysqldump так как мне не хватало пакета mariadb-connector-c для подключения
cat <<EOF >./Dockerfile
FROM schnitzler/mysqldump:latest

RUN apk --update add mysql-client mariadb-connector-c
EOF

docker build . -t vshishkov/mysqldump:1.0.0

rm -f Dockerfile

# При ручном запуске можно запрашивать у пользоватателя root пароль для БД
#read -sp 'Please, entry DB root password: ' DB_ROOT_PASSWORD
#echo

#Единоразово запускаю контейнер mysqldump чтобы сделать дамп БД
docker run \
    --rm --entrypoint "" \
    -v /opt/backup:/backup \
    --network=repo_backend \
    --ip=172.20.0.15 \
    vshishkov/mysqldump:1.0.0 \
    mysqldump --opt -h 172.20.0.10 -u root -p$DB_ROOT_PASSWORD "--result-file=/backup/"$(date +"%s_%Y-%m-%d")"-dumps.sql" example
