FROM registry.access.redhat.com/ubi8/nginx-120
USER root

COPY ./nginx.conf /etc/nginx/nginx.conf
ENV APP_MODULE /code


RUN yum install -y --disableplugin=subscription-manager python3 && \
    yum install -y --disableplugin=subscription-manager python3-pip && \
    yum clean all --disableplugin=subscription-manager -y

WORKDIR /code

COPY ./src /code/

RUN chgrp -R 0 /code  && \
    chmod -R g=u /code 

USER 1001 

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
