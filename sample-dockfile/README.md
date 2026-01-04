#### 构建镜像
```shell
- Build a docker image using the Dockerfile in the current directory:
    docker build .

- Build a docker image from a Dockerfile at a specified URL:
    docker build github.com/creack/docker-firefox

- Build a docker image and tag it:
    docker build --tag name:tag .

- Build a docker image with no build context:
    docker build --tag name:tag - < Dockerfile

- Do not use the cache when building the image:
    docker build --no-cache --tag name:tag .

- Build a docker image using a specific Dockerfile:
    docker build --file Dockerfile .

- Build with custom build-time variables:
    docker build --build-arg HTTP_PROXY=http://10.20.30.2:1234 --build-arg FTP_PROXY=http://40.50.60.5:4567 .
```

执行构建命令
```shell
docker build --tag very-simple-web .   
```
查看所有镜像
```shell
 docker images                       
REPOSITORY                        TAG          IMAGE ID       CREATED         SIZE
very-simple-web                   latest       6eb07ba52f45   8 minutes ago   141MB
bitnami/zookeeper                 3.8          e0d1f331bd2f   8 days ago      510MB
bitnami/kafka                     3.4          95454f5a72bb   8 days ago      551MB
elasticsearch                     7.17.5       11df7a62573d   9 months ago    610MB
docker.elastic.co/kibana/kibana   7.17.5       5756b819359b   9 months ago    802MB
```
删除某个镜像
```shell
docker rmi 6eb07ba52f45
```
启动镜像
```shell
docker-compose up -d
```