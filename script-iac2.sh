#!/bin/bash

## Script deve ser executado com o usuário root e não usando sudo, dependência do cron!

echo "Atualizando e instalando as dependencias no servidor..."
apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apache2 unzip git

clear

echo "Baixando e copiando os arquivos da aplicação..."
rm -rf /var/www/html
git clone https://github.com/denilsonbonatti/linux-site-dio.git /var/www/html/

systemctl --now apache2

echo "Automatizando a atualização!"

echo "0 * * * * root git pull /var/www/html/ >/dev/null 2>&1" >> /etc/crontab
echo "0 * * * * root systemctl reload apache2 >/dev/null 2>&1" >> /etc/crontab
