#!/bin/bash

# Si n’importe quelle commande échoue (code de retour ≠ 0), le script s’arrête immédiatement à cette ligne-là, sans exécuter la suite.
set -e 

# pré-requis:
# sudo apt install docker.io
# sudo systemctl start docker

echo "=> Nettoyage"
make clean

echo "=> Build en cours..."
sudo docker build -t inufuto-tools .

echo "=> Récupération des binaires..."
CONTAINER_ID=$(sudo docker create inufuto-tools)
sudo docker cp $CONTAINER_ID:/src/asm8-2.0.0/Asm09/bin/Release/net8.0/linux-x64/publish/Asm09 .
sudo docker cp $CONTAINER_ID:/src/asm8-2.0.0/LinkBE/bin/Release/net8.0/linux-x64/publish/LinkBE .
sudo docker cp $CONTAINER_ID:/src/asm8-2.0.0/Lib8/bin/Release/net8.0/linux-x64/publish/Lib8 .
sudo docker cp $CONTAINER_ID:/src/Cate-2.4.2/Cate09/bin/Release/net8.0/linux-x64/publish/Cate09 .
sudo docker rm $CONTAINER_ID

sudo chown $(whoami):$(whoami) Asm09 LinkBE Lib8 Cate09

#echo "=> Création du runtime avec les binaires..."
#make -C Cate-2.4.2/runtime/6809

echo "=> Nettoyage du cache Docker..."
sudo docker images
sudo docker system prune -f --all --volumes
sudo docker images

# pour debug:
# sudo docker run --rm -it inufuto-tools bash

