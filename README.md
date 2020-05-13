## MySQL in Docker

### Create a MySQL Image
- Refer Docker file
- Also see "Initializing a fresh instance" at https://hub.docker.com/_/mysql

### Steps to run
- `$ cd to current directory`
- `$ docker build -t mysql-docker .`
- `$ docker run --name mysql-docker-image -d -p 3306:3306 mysql-docker`
- `$ docker container exec -it mysql-docker-image bash`
  - `$# mysql -uroot -pdev`
  - $# show databases;`  // should see company
  - `$# use company;`
  - `$# show tables;`     // should see tables
  - `$# select * from employees;`


## If you want to run a mysql image locally (without creating any custom mysql image like above, see below process)

### Run DB in docker
- Go to, https://hub.docker.com/_/mysql
- Choose 5.6 tag
- `$ docker run --name mysql-docker-demo -e MYSQL_ROOT_PASSWORD=dev -d mysql:5.6`   (see cmds from above url)
    Here,
    --name is "mysql-docker-demo"
    -e is env variable where MYSQL_ROOT_PASSWORD is "dev" (user will be root)
    -d is demon
    mysql tag will be "mysql:5.6"
- `$ docker ps` (to get the container number)
- `$ docker container logs <con-id>` (to see container logs)
- `$ docker container exec -it <con-id> bash` (you'll be logged in to the machine)
- `$# mysql -uroot -pdev`
- `$# show databases`
- $# You can create a DB here but that won't be enough bcoz we will destroy this image anyway (See below about how to create a DB)


### How to create your own database
- `$ docker run --name mysql-docker-demo -e MYSQL_ROOT_PASSWORD=dev -e MYSQL_DATABASE=company -d mysql:5.6`
  Here, with -e we can add another env variable. Here we have specified MYSQL_DATABASE as "company"
- `$ docker container exec -it <con-id> bash` (you'll be logged in to the machine)
- `$# mysql -uroot -pdev`
- `$# show databases`    (should see "company" db)
- NOTE: It is always a good practice to run a separate container(attach it to same network) to check what are present in mysql,
  `$ docker run -it --network spring-boot-network alpine`
    - `$# ping mysql-docker-demo`   (should be able to access)
    - `$# apk add --no-cache  mysql-client`   (apk is like yum)
    - `$# mysql -uroot -pdev -hmysql-docker-demo`

## Run it on a network (so that other containers(like a spring-boot-app) can access the database container)
- `$ docker network create spring-boot-network`  (some name)
- `$ docker network ls`
- `$ docker run --network spring-boot-network --name mysql-docker-demo -e MYSQL_ROOT_PASSWORD=dev -e MYSQL_DATABASE=company -d mysql:5.6`
  ### Here,
  - --network should give "spring-boot-network"
- Now run, docker-spring-boot-demo in a container and make sure it is linked to the same network as mysql,
  `$ docker run --network spring-boot-network --name docker-spring-boot-demo  -d -p 8181:8181 amarnath510/docker-spring-boot-demo`
- NOTE: Always use --name and give names to your containers
- Now login to `docker container exec -it docker-spring-boot-demo bash`
  - `$# ping google.com`
    PING google.com (172.217.160.142) 56(84) bytes of data.
    64 bytes from maa03s29-in-f14.1e100.net (172.217.160.142): icmp_seq=1 ttl=37 time=45.2 ms
    64 bytes from maa03s29-in-f14.1e100.net (172.217.160.142): icmp_seq=2 ttl=37 time=90.6 ms
  - `$# ping mysql-docker-demo`       NOTE: This should work only then we will be able to access the database
    PING mysql-docker-demo (172.18.0.2) 56(84) bytes of data.
    64 bytes from mysql-docker-demo.spring-boot-network (172.18.0.2): icmp_seq=1 ttl=64 time=0.104 ms
    64 bytes from mysql-docker-demo.spring-boot-network (172.18.0.2): icmp_seq=2 ttl=64 time=0.075 ms

