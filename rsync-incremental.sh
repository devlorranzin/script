#!/bin/bash 

#Variaveis
DATA=`date +%d-%m-%Y_%H-%M`
MONTAGEM='/mnt/bkp/'
DIR=BACKUP_$DATA
IP=''
DEST=''
USER=''
PASSWD=''

#Programação

mount -t cifs //$IP/$DEST -o username=$USER,password=$PASSWD $MONTAGEM
cd $MONTAGEM


if [ -e "$DIR" ];
then
    echo "O backup já foi executado"
else
    mkdir BACKUP_$DATA
    rsync -axvHAWXS /var/eucatur/ $MONTAGEM/BACKUP_$DATA
    cd ..
    umount /mnt/bkp
    
fi
