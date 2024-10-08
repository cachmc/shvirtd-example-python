#!/bin/bash

#Устанавливаю Docker
sudo apt-get update
sudo apt-get install ca-certificates curl git -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

#Добавляю зеркала для Docker
echo \
"{
  \"registry-mirrors\": [
     \"https://mirror.gcr.io\",
     \"https://daocloud.io\",
     \"https://c.163.com/\",
     \"https://registry.docker-cn.com\"
   ]
}" | \
  sudo tee /etc/docker/docker.json > /dev/null

#Перезапускаю Docker
sudo systemctl restart docker

#sudo usermod -a -G docker $USER

#Создаю каталог для клонирования форка
sudo chmod 777 /opt

mkdir /opt/repo

#Клонирования форка
git clone git@github.com:cachmc/shvirtd-example-python.git /opt/repo

#Собираю образ WEB Application
sudo docker build /opt/repo/ -t cr.yandex/crpooo92jkf633et5esq/web_app_py:1.0.0 -f /opt/repo/Dockerfile.python

#Запускаем контейнеры
sudo docker compose -f /opt/repo/compose.yaml up -d
