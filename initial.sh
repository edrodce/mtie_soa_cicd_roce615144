#!/bin/bash
echo '=========================================================='
echo '                EDUARDO RODRÍGUEZ CERVANTE                '
echo '     MODELOS DE ARQUITECTURAS ORIENTADAS A SERVICIOS      '
echo '    MAESTRIA EN TECNOLOGIAS DE INFORMACION EMPRESARIA    '
echo '              UNIVERSIDAD DE LA SALLE BAJIO               '
echo '=========================================================='
echo '                        karroyodev                        '
echo '                                                          '
echo '                             ##          ·                '
echo '                       ## ## ##         ==                '
echo '                    ## ## ## ## ##     ===                '
echo '                 /""""""""""""""""\____/ ===              '
echo '            ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~       '
echo '                 \______             __/                  '
echo '                   \    \         __/                     '
echo '                    \____\_______/                        '
echo '                                                          '
echo '                      INICIAMOS  SETUP                     '
echo '                                                          '
echo '=========================================================='
echo '===  PASO 1: CONFIGURAR DE VARAIBLE VM.MAX_MAP_COUNT   ==='
echo '=========================================================='
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p

echo '=========================================================='
echo '===       PASO 2: INSTALACION DE DOCKER-COMPOSE        ==='
echo '=========================================================='
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo '=========================================================='
echo '===       PASO 3: LIMPIEZA DE REPOSITORIO LOCAL        ==='
echo '=========================================================='
if [ -d ~/mtie_soa_cicd_roce615144/ ]; then
    echo 'sudo rm -R mtie_soa_cicd_roce615144'
    sudo rm -R mtie_soa_cicd_roce615144
else
    echo 'El repositorio anterior no existe...'
fi

echo '=========================================================='
echo '===                    PASO 4: GIT                     ==='
echo '=========================================================='
alias git="docker run -ti --rm -v $(pwd):/git bwits/docker-git-alpine"

echo '=========================================================='
echo '===             PASO 5: CLONAR REPOSITORIO             ==='
echo '=========================================================='
git clone https://github.com/edrodce/mtie_soa_cicd_roce615144.git
cd mtie_soa_cicd_roce615144

echo '=========================================================='
echo '===          PASO 6: LIMPIEZA DE DATA                  ==='
echo '=========================================================='
if [ -d ~/volumes/ ]; then
    echo 'sudo rm -R volumes'
    sudo rm -R volumes
else
    echo ''
    echo 'No existe la carpeta volumes anterior...'
fi

if [ -d ~/data/ ]; then
    echo 'sudo rm -R data'
    sudo rm -R data
else
    echo ''
    echo 'No existe la carpeta volumes data anterior...'
fi

echo '=========================================================='
echo '===   PASO 7: CARPETAS DE volumes PARA ELASTICSEARCH   ==='
echo '=========================================================='
if [ -d ./volumes/ ]; then
    sudo cp -R volumes/ ~/
    sudo mkdir -p ~/volumes/elk-stack/elasticsearch
    cd ~/volumes/elk-stack/
    sudo chmod 777 elasticsearch/
    cd ~/mtie_soa_cicd_roce615144
else
    echo 'No existe la carpeta volumes'
fi

if [ -d ./data/ ]; then
    echo 'sudo cp -R data/ ~/'
    sudo cp -R data/ ~/
else
    echo 'No existe la carpeta data'
fi

echo '=========================================================='
echo '===          PASO 8: CREACION DE CONTENEDORES          ==='
echo '=========================================================='
echo 'sudo docker-compose up --build -d'
sudo docker-compose up --build -d