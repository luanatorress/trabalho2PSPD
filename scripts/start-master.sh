#!/bin/bash

# Configurar variáveis de ambiente PRIMEIRO
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export HADOOP_HOME=/home/hadoop/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

echo "==> Formatando NameNode..."
$HADOOP_HOME/bin/hdfs namenode -format -force

echo "==> Iniciando Hadoop Master (NameNode + ResourceManager)"
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

echo "==> Hadoop Master em execução"
tail -f /dev/null