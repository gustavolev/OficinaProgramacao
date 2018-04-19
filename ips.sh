#!/bin/bash

echo "===============================================================" > RELATORIO.txt
echo "" >> RELATORIO.txt
MAQUINA=$(uname -a | cut -d ' ' -f2)
echo Relatorio feito na maquina: $MAQUINA >> RELATORIO.txt
DATA=$(date '+%H:%M:%S -- %D/%M/%Y')
echo Data/Hora: $DATA >> RELATORIO.txt
echo "" >> RELATORIO.txt
echo "===============================================================" >> RELATORIO.txt

nmap -sP 192.168.9.70/24 > NMAP.txt

ARQUIVO="NMAP.txt"

cat $ARQUIVO | grep "Nmap scan" | cut -d " " -f5  > IP.txt

cat $ARQUIVO | grep "MAC" > MAC.txt

LINES=$(wc -l IP.txt | cut -d " " -f1)

for i in $(seq "1" "$LINES")
do
	IP=$(head -n${i} IP.txt | tail -n 1)
	MAC=$(head -n${i} MAC.txt | tail -n 1)
	SO=$(nmap -O $IP)
	echo "$IP" >> RELATORIO.txt
	echo "$MAC" >> RELATORIO.txt
	echo "$SO" > RELATORIO.txt
done


ssmtp teste123@hotmail.com < RELATORIO.txt
