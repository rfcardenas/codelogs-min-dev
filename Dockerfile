FROM maven:3.3.9-jdk-8-alpine

ENV FOLDER_ENV env/.

ENV FOLDER_KEYS keys/.

MAINTAINER Ronald Cardenas <rfcardenas@gmail.com>

# INSTALL
RUN apk update && apk add --update --no-progress nodejs unrar bash git openssh python g++ make && \ 
  npm install -g bower gulp 


#CREATE DIRS
RUN mkdir /root/.ssh/

#COPY KEYS
ADD ${FOLDER_KEYS} /root/.ssh/


#COPY 
ADD ${FOLDER_ENV} /root/.m2/

#StrictHostKeyChecking NO 
RUN echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

#PERMISOS id_rsa
RUN chmod 600 /root/.ssh/id_rsa

#SETUP GIT
RUN git config --global user.name "DEV ICL TOOL" && git config --global user.email rfcardenas92@gmail.com

#CLEAN 
RUN rm /var/cache/apk/*

