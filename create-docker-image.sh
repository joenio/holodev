#!/bin/sh

# cria imagem "noosfero" baseado em Debian Wheezy
#docker build -t noosfero .

# baixa arquivos necessários para instalar requisitos em Debian Wheezy
git clone --depth 1 http://gitlab.com/noosfero/noosfero.git noosfero-upstream

#mkdir noosfero-upstream-files; cd noosfero-upstream-files
#wget http://gitlab.com/noosfero/noosfero/raw/master/Gemfile
#mkdir debian; cd debian
#wget http://gitlab.com/noosfero/noosfero/raw/master/debian/control
#cd ..
#mkdir script; cd script
#wget http://gitlab.com/noosfero/noosfero/raw/master/script/quick-start
#chmod +x quick-start
#mkdir install-dependencies; cd install-dependencies
#wget http://gitlab.com/noosfero/noosfero/raw/master/script/install-dependencies/debian-wheezy.sh
#chmod +x debian-wheezy.sh
#cd ..; cd ..
#mkdir config; cd config
#wget http://gitlab.com/noosfero/noosfero/raw/master/config/database.yml.pgsql
#cd ..
#cd ..

# executa comando usando imagem "noosfero" e cria novo container
docker run -v $(pwd)/noosfero-upstream-files:/tmp/noosfero-files -i -t noosfero /tmp/noosfero-files/script/quick-start

# cria snapshot local chamado "noosfero" com o ambiente de desenvolvimento noosfero instalado
docker commit `docker ps -l -q` noosfero

#rm -rf noosfero-upstream-files
