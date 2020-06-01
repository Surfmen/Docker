FROM ubuntu
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git \
        && apt-get install -y iputils-ping
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f1.txt

RUN mkdir /datos2
WORKDIR /datos2
RUN touch f2.txt

## COPY ##
COPY index.html .
COPY app.log /datos1

## ADD ##
ADD docs docs
ADD f* /datos1/
ADD f.tar .

## ENV ##
## variable para cuando creo el contenedor ##
ENV dir1=/data1 dir2=/data2
RUN mkdir $dir1 && mkdir $dir2

## ARG ##
## Permite pasar el valor al contruir la imagen ##
#ARG dir3
#RUN mkdir $dir3
#ARG user
#ENV user_docker $user
#ADD add_user.sh /datos1
#RUN /datos1/add_user.sh

## EXPOSE ##
## Nos permite exponer PUERTOS que se van usar con alguno de los productos que se van instalar en esta imagen
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos1

##VOLUME##
ADD paginas /var/www/html
VOLUME ["/var/www/html"]

## CMD ##
CMD /datos1/entrypoint.sh

## ENTRYPOINT ##
# Para que entre en el shell
#ENTRYPOINT ["/bin/bash"]
