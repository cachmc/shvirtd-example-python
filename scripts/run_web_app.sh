#!/bin/bash

##Написал скрипт для задания 1.3 :)

#Запускаю MySQL в докер контейнере
docker run --name mysql_db --env-file mysql.list.env -p 3306:3306 -d mysql:8.0-oraclelinux8

#Экспортирую ENV которые будет использовать WEB Application для подключения к БД
for variable in $(cat web.list.env)
do 
    export $(echo $variable)
done

#Запускаю WEB Application
sleep 30s
python /opt/repo/main.py
