# Домашнее задание к занятию «Обновление приложений»

## Задание 1. Выбрать стратегию обновления приложения и описать ваш выбор

1. Имеется приложение, состоящее из нескольких реплик, которое требуется обновить.
2. Ресурсы, выделенные для приложения, ограничены, и нет возможности их увеличить.
3. Запас по ресурсам в менее загруженный момент времени составляет 20%.
4. Обновление мажорное, новые версии приложения не умеют работать со старыми.
5. Вам нужно объяснить свой выбор стратегии обновления приложения.

Вопрос упирается в ресурсы, в задаче не указано сколько реплик приложения у нас поднимается, сколько подов и т.д.
Так же много вопросов к "запасу в менее загруженный момент". мы не знаем, хватит ли этого запаса на поднятие хоть одного пода,
и так же нет никаких требований к доступности приложения во время обновления

Если строго следовать условиям задачи, то выбор у нас один - Recreate. Т.е. Убиваем все текущие поды, создаем новые 
с новой версией. Такое решение удовлетворяет всем условиям задачи.


## Задание 2. Обновить приложение
1. Создать deployment приложения с контейнерами nginx и multitool. Версию nginx взять 1.19. Количество реплик — 5.
2. Обновить версию nginx в приложении до версии 1.20, сократив время обновления до минимума. Приложение должно быть доступно.
3. Попытаться обновить nginx до версии 1.28, приложение должно оставаться доступным.
4. Откатиться после неудачного обновления.


<details>
<summary>Deployment приложения с контейнерами nginx и multitool

</summary>

```RollingUpdate
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
  labels:
    app: upApp
spec:
  replicas: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  selector:
    matchLabels:
      app: upApp
  template:
    metadata:
      labels:
        app: upApp
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
        ports:
        - containerPort: 80
      - name: network-multitool
        image: wbitt/network-multitool
        env:
        - name: HTTP_PORT
          value: "8080"
        - name: HTTPS_PORT
          value: "11443"
        ports:
        - containerPort: 8080
        - containerPort: 11443
---
apiVersion: v1
kind: Service
metadata:
  name: svcupapp
spec:
  ports:
    - name: web-nginx
      port: 9001
      targetPort: 80
    - name: web-multi
      port: 9002
      targetPort: 8080
  selector:
    app: upApp
```
</details>

Во время обновления до версии 1.20 - приложение было доступно, проверял с помощью curl

<details>
<summary>kubectl exec deployments/app-deployment -- curl svcupapp:9002

</summary>

```multitool
kubectl exec deployments/app-deployment -- curl svcupapp:9002
Defaulted container "nginx" out of: nginx, network-multitool
WBITT Network MultiTool (with NGINX) - app-deployment-6965d9bc5f-9dldh - 10.1.85.43 - HTTP: 8080 , HTTPS: 11443 . (Formerly praqma/network-multitool)
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   150  100   150    0     0   146k      0 --:--:-- --:--:-- --:--:--  146k
```
</details>

и

<details>
<summary>kubectl exec deployments/app-deployment -- curl svcupapp:9001

</summary>

```nginx
Defaulted container "nginx" out of: nginx, network-multitool
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:100   615  100   615    0     0   600k      0 --:--:-- --:--:-- --:--:--  600k
```
</details>

Попытка обновитиьтся до версии 1.28

<details>
<summary>kubectl get pods

</summary>

```kubectl get pods
kubectl get pods
NAME                              READY   STATUS             RESTARTS   AGE
app-deployment-6965d9bc5f-j98g8   2/2     Running            0          4m34s
app-deployment-6965d9bc5f-c4gs5   2/2     Running            0          4m38s
app-deployment-6965d9bc5f-9dldh   2/2     Running            0          4m15s
app-deployment-6965d9bc5f-vrnrv   2/2     Running            0          4m9s
app-deployment-6dbf7fb48-wtj6s    1/2     ImagePullBackOff   0          109s
app-deployment-6dbf7fb48-fr5wk    1/2     ImagePullBackOff   0          106s
```
</details>

Откат после неудачного обновления
<details>
<summary>kubectl rollout undo deployment app-deployment 

</summary>

```kubectl rollout undo
kubectl rollout undo deployment app-deployment 
deployment.apps/app-deployment rolled back
```
</details>
<details>
<summary>kubectl get pods

</summary>

```kubectl get pods
kubectl get pods
NAME                              READY   STATUS    RESTARTS   AGE
app-deployment-6965d9bc5f-j98g8   2/2     Running   0          9m1s
app-deployment-6965d9bc5f-c4gs5   2/2     Running   0          9m5s
app-deployment-6965d9bc5f-9dldh   2/2     Running   0          8m42s
app-deployment-6965d9bc5f-vrnrv   2/2     Running   0          8m36s
app-deployment-6965d9bc5f-l8lt8   2/2     Running   0          19s
```
</details>

