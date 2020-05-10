FROM mysql:5.6

ENV MYSQL_ROOT_PASSWORD=dev
ENV MYSQL_DATABASE=company

ADD ./company.sql /docker-entrypoint-initdb.d

EXPOSE 3306
