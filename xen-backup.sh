#!/bin/bash 

# Script de backup das VM's Xen-Server (VM's RODANDO)

$VM=""
$BKP_DIR="/mnt/backup"

dhvm=`date +%d-%m-%Y_%H-%M-%S`

#Cria um snapshot da maquina rodando
idvm=`xe vm-snapshot vm=$VM new-name-label=$VM-snapshot`

#Converte o snapshot criado em template
xe template-param-set is-a-template=false uuid=$idvm

#Converte o template em VM 
cvvm=`xe vm-copy vm=$VM-snapshot sr-uuid=6ba2c535-8037-022d-a57b-e7265bbcc224 new-name-label=$VM-$dhvm`

#Exporta VM criada para a pasta montada do servidor NFS-BACKUP, HD externo ou qualquer outro armazenamento
xe vm-export vm=$cvvm filename=$BKP_DIR/$VM-$dhvm.xva

#Deleta o snapshot criado
xe vm-uninstall --force uuid=$idvm

#Deletar a VM criada e seu VDI
xe vm-uninstall vm=$cvvm force=true

# Excluir todos os arquivos,deixa apenas os dois ultimos criados
ls -td1 $BKP_DIR/* | sed -e '1,2d' | xargs -d '\n' rm -rif

##########################################################################