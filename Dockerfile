FROM ubuntu:22.04
LABEL maintainer="Luana Torres"

ENV DEBIAN_FRONTEND=noninteractive
ENV HADOOP_VERSION=3.3.6

# Instala dependencias
RUN apt update && apt install -y \
    openjdk-11-jdk openssh-server openssh-client rsync wget vim nano iputils-ping && \
    apt clean

# Cria usuário Hadoop
RUN useradd -m -s /bin/bash hadoop && echo "hadoop:hadoop" | chpasswd

# Copia Hadoop
COPY hadoop-3.3.6.tar.gz /tmp/
RUN tar -xzf /tmp/hadoop-3.3.6.tar.gz -C /home/hadoop/ && \
    mv /home/hadoop/hadoop-3.3.6 /home/hadoop/hadoop && \
    rm /tmp/hadoop-3.3.6.tar.gz && \
    chown -R hadoop:hadoop /home/hadoop/hadoop

# Variáveis de ambiente
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV HADOOP_HOME=/home/hadoop/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# Configura SSH como root (mais simples)
RUN mkdir -p /var/run/sshd && \
    ssh-keygen -A && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config

# Configura SSH para usuário hadoop
USER hadoop
RUN mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh && \
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 600 ~/.ssh/authorized_keys

USER root

# Copia configs
COPY config/ $HADOOP_HOME/etc/hadoop/
COPY scripts/ /home/hadoop/scripts/
RUN chmod +x /home/hadoop/scripts/*.sh && \
    chown -R hadoop:hadoop /home/hadoop/scripts

EXPOSE 9870 8088 9864 8042 22

# Entrypoint simplificado
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "sleep infinity"]
