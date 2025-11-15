# Como subir o ambiente:

hadoop-cluster$ 
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz



No terminal:

```
cd hadoop-cluster
docker compose build
docker compose up -d
```

Acessar o master:

docker exec -it master bash


Interfaces web:

NameNode → http://localhost:9870

YARN → http://localhost:8088



---------------------

Na pasta hadoop-docker-cluster:

docker compose build
docker compose up -d


Verifique:

docker ps


Acesse o master:

docker exec -it master bash

su - hadoop

ssh slave1

p/ conseguir ips de cada
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' master
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' slave1
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' slave2

p/ colocar ips de config no etc/hosts para estabelecer comunicação 
docker exec -it --user root slave2 nano /etc/hosts (em cada um dos conteineres)

p/ encerrar o docker

docker compose down -v


----------------------

# Atividade Extraclasse – Hadoop e Spark
Curso: Engenharia de Software – Universidade de Brasília (UnB)
Disciplina: Sistemas Distribuídos
Turma: 2025/1
Alunos: Luana Souza Silva Torres
Data: 15/11/25

1. Introdução

Esta atividade extraclasse teve como objetivo implementar, configurar e executar experimentos em um ambiente distribuído utilizando os frameworks Apache Hadoop e Apache Spark.
O trabalho consistiu em:

construir um cluster Hadoop funcional em ambiente Docker;

realizar testes de desempenho e tolerância a falhas (item B1);

configurar e executar aplicações em Spark, registrando dificuldades e aprendizados (item B2);

relatar os resultados em formato de relatório técnico.

2. Experimento com Hadoop (Item B1)
2.1 Arquitetura do Cluster

O cluster Hadoop foi organizado utilizando contêineres Docker, estruturado da seguinte forma:

Master Node

NameNode (HDFS)

ResourceManager (YARN)

SecondaryNameNode

Slave Nodes

Cada slave executa:

DataNode (armazenamento HDFS)

NodeManager (execução de tasks)

Tentamos montar via máquinas virtuais mas tivemos diversos problemas de redes e de incompatibilidade. Quando finalemnte conseguimos resolver os problemas de rede, tivemos problemas no desemprenho do computador subindo 2 VM's e utilizando o notebook como host (master), para tanto, decidimos adotar a estratégia de usar conteineres.

Na utilização de conteineres encontramos diversos problemas na formatação do hadoop, problemas na configuração de ssh e problemas para subir os conteineres todos na mesma rede. Por fim, apesar de termos resolvido esses problemas, ficamos sem tempo hábil para finalizar a entrega, ainda mais com a desistência dos outros membros do grupo.

No trabalho 1 erámos 5, mas 3 participantes acabaram não participando da entrega, assim ficamos em dois. Nesse segundo trabalho o outro participante não conseguiu me auxiliar então apenas a aluna Luana Torres ficou responsável pelo trabalho.


4. Conclusão

Apesar de não ter conseguido rodar o haddop em cluester com o uso dos containeres, consegui rodar pelo noteboook disponibilizado pelo professor e localmente na minha máquina, sem cluester. Acredito que o trabalho foi de grande aprendizado, e faltaram apenas poucos detalhes para que o cluster rodasse 100%, se tivesse um pouco mais de tempo acredito que teria entregado tudo conforme solicitado.