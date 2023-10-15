# Домашнее задание к занятию «Запуск приложений в K8S»

#

## Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod

1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью curl, что из пода есть доступ до приложений из п.1.

### Решение
Количестов подов до масштабирования
![screen](/screen/12-adminkube-03-1.png)

Количество подов после масштабирования
![screen](/screen/12-adminkube-03-2.png)

Сервис, который обеспечивает доступ до реплик приложений

![screen](/screen/12-adminkub-03-3.png)

<details>
<summary>YAML файл
</summary>

```commandline
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: lesson2
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
        ports:
          - name: http-nginx
            containerPort: 80
      - name: init-multi
        image: wbitt/network-multitool:openshift-extra
        ports:
          - name: http-multi
            containerPort: 11443
---
apiVersion: v1
kind: Service
metadata:
  name: deployment-svc
  namespace: lesson2
spec:
  ports:
    - name: http-nginx
      port: 80
    - name: http-multi
      port: 11443
      targetPort: http-multi
  selector:
    app: nginx
```
</details>

отдельный Pod с доступом до приложений

![screen](/screen/12-adminkub-03-4.png)

<details>
<summary>YAML файл c Pod
</summary>

```commandline
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: lesson2
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
        ports:
          - name: http-nginx
            containerPort: 80
      - name: init-multi
        image: wbitt/network-multitool:openshift-extra
        ports:
          - name: http-multi
            containerPort: 11443
---
apiVersion: v1
kind: Service
metadata:
  name: deployment-svc
  namespace: lesson2
spec:
  ports:
    - name: http-nginx
      port: 80
    - name: http-multi
      port: 11443
      targetPort: http-multi
  selector:
    app: nginx
---
apiVersion: v1
kind: Pod
metadata:
  name: ext-multi
  namespace: lesson2
  labels:
    app: multi
spec:
  containers:
  - name: ext-multi
    image: wbitt/network-multitool
    ports:
      - name: ext-multi
        containerPort: 443
```
</details>

#

## Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.

Создал деплой, убедился, что nginx  не стартует
![screen](/screen/12-adminkube-03-5.png)

Создал и запустил сервис, под после запуска.
![screen](/screen/12-adminkube-03-6.png)