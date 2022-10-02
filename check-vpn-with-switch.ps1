#SCRIPT PARA MUDANÇA ENTRE VPNS COM POWERSHELL -PS1 #
#SCRIPT DESENVOLVIDO POR - LORRAN DOUGLAS PROCÓPIO GONÇALVES - ANALISTA DE INFRAESTRUTURA #

###########################################################################################

#Host que ira ser pingado
$IP=""  #IP DE UM HOST PARA TESTE
$VPN1="" # NOME DA VPN PRINCIPAL 
$VPN2="" # NOME da VPN SECUNDARIA
$USER="" #USER DA VPN
$PASSWD=""  #PASSWD DA VPN

#Enquanto estiver pingando no $IP o laço ira acontecer
do{
	
    Start-Sleep -s 10
	$RESULTADO=Test-Connection $IP -Count 1 -Quiet
    if($RESULTADO -eq "true"){
        Write-Output "O ping esta chegando no host $IP"
    }

     
}while ($RESULTADO -eq "true")

#ADICIONE SUAS ROTAS
route delete 200.241.66.187 MASK 255.255.255.255 172.27.0.1
route delete 187.28.188.242 MASK 255.255.255.255 172.27.0.1
route delete 179.252.20.140 MASK 255.255.255.255 172.27.0.1
route delete 192.168.10.0 MASK 255.255.255.0 172.27.0.1
route delete 172.29.1.0 MASK 255.255.255.240 172.27.0.1
route delete 192.168.0.0 MASK 255.255.255.0 172.27.0.1
route delete 192.168.2.0 MASK 255.255.255.0 172.27.0.1
rasdial.exe /DISCONNECT

Start-Sleep -s 5

rasdial.exe $VPN2 $USER $PASSWD
route ADD 200.241.66.187 MASK 255.255.255.255 172.27.0.1
route ADD 187.28.188.242 MASK 255.255.255.255 172.27.0.1
route ADD 179.252.20.140 MASK 255.255.255.255 172.27.0.1
route ADD 192.168.10.0 MASK 255.255.255.0 172.27.0.1
route ADD 172.29.1.0 MASK 255.255.255.240 172.27.0.1
route ADD 192.168.0.0 MASK 255.255.255.0 172.27.0.1
route ADD 192.168.2.0 MASK 255.255.255.0 172.27.0.1

Start-Sleep -s 20

#Enquanto estiver pingando no $IP o laço ira acontecer
do{
	
    Start-Sleep -s 5
	$RESULTADO=Test-Connection $IP -Count 1 -Quiet
    if($RESULTADO -eq "true"){
        Write-Output "O ping esta chegando no host $IP com a $VPN2"
    }


}while ($RESULTADO -eq "true")


Write-Output "O ping não encontrou o host, apagando as rotas e desconectando de todas as vpns"
route delete 200.241.66.187 MASK 255.255.255.255 172.27.0.1
route delete 187.28.188.242 MASK 255.255.255.255 172.27.0.1
route delete 179.252.20.140 MASK 255.255.255.255 172.27.0.1
route delete 192.168.10.0 MASK 255.255.255.0 172.27.0.1
route delete 172.29.1.0 MASK 255.255.255.240 172.27.0.1
route delete 192.168.0.0 MASK 255.255.255.0 172.27.0.1
route delete 192.168.2.0 MASK 255.255.255.0 172.27.0.1
rasdial.exe /DISCONNECT