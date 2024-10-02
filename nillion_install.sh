#!/bin/bash

sudo apt-get update
curl -s https://raw.githubusercontent.com/DOUBLE-TOP/tools/main/main.sh | bash &>/dev/null
curl -s https://raw.githubusercontent.com/DOUBLE-TOP/tools/main/docker.sh | bash &>/dev/null
sudo apt-get install --only-upgrade -y docker-ce docker-ce-cli containerd.io

sudo systemctl restart docker
docker --version

# Закидываем докер ниллион
if docker pull nillion/verifier:1.0.1; then
  echo "Образ успешно загружен"
else
  echo "Ошибка загрузки образа" >&2
  exit 1
fi

mkdir -p nillion/verifier
sleep 30
docker run -v ./nillion/verifier:/var/tmp nillion/verifier:1.0.1 initialise
echo "Установка завершена!"
