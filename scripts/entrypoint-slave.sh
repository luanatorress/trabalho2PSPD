#!/bin/bash
set -e

echo "==> Configurando SSH..."
/usr/sbin/sshd -D &
sleep 5

echo "==> Aguardando Master..."
sleep 30

echo "==> Iniciando Hadoop Slave..."
exec su - hadoop -c "/home/hadoop/scripts/start-slave.sh"