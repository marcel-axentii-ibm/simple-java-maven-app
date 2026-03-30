# Folosim imaginea oficială Jenkins LTS (care vine cu JDK inclus)
FROM jenkins/jenkins:lts

# Trecem la utilizatorul root pentru a instala pachete
USER root

# Actualizăm depozitele și instalăm Maven
RUN apt-get update && \
    apt-get install -y maven && \
    # Curățăm cache-ul pentru a reduce dimensiunea imaginii
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ne asigurăm că directorul home este /home/jenkins (standard în imaginea oficială)
# Dacă vrei să forțezi crearea lui sau permisiuni specifice:
RUN mkdir -p /home/jenkins/.m2 && \
    chown -R jenkins:jenkins /home/jenkins

# Setăm variabilele de mediu pentru Maven
ENV MAVEN_HOME=/usr/share/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

# Revenim la utilizatorul jenkins pentru securitate
USER jenkins

# Setați directorul de lucru
WORKDIR /home/jenkins
