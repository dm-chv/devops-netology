сделал простой конфиг nginx, простой html файл, просотой docker file

билдим докер файл, создаем образ

```
$ sudo docker build -t simpleapp:v1 .
```

протестим созданный образ

```
$ docker run -d -p 88:80 --name diplom simpleapp:v1
```
проверим запущен ли контейнер

```
$ docker ps
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                                   NAMES
412e2367a230   simpleapp:v1            "nginx -g 'daemon of…"   5 seconds ago    Up 3 seconds    0.0.0.0:88->80/tcp, :::88->80/tcp       diplom
```

протестим курлом


```
$ curl -I localhost:88
HTTP/1.1 200 OK
Server: nginx/1.26.0
Date: Wed, 22 May 2024 13:49:52 GMT
Content-Type: text/html
Content-Length: 48
Last-Modified: Wed, 22 May 2024 13:21:44 GMT
Connection: keep-alive
ETag: "664df168-30"
Accept-Ranges: bytes
#______________________________
#
$ curl localhost:88
<h1>hello</h1>
<h2> i am simple static page</h2>
```

Запушим в докер хаб
 
```
# логинимся 
docker login --username MY_USER_NAME
docker push chaltsev/simpleapp:v1
docker logout
```
