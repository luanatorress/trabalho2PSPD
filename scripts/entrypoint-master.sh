#!/bin/bash
set -e

echo "==> Configurando SSH..."
/usr/sbin/sshd -D &
sleep 5

echo "==> Iniciando Hadoop Master..."
exec su - hadoop -c "/home/hadoop/scripts/start-master.sh"