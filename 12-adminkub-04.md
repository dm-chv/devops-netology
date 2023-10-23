# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 1»

#

## Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера
1. Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт.
2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080.
3. Создать отдельный Pod с приложением multitool и убедиться с помощью curl, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры.
4. Продемонстрировать доступ с помощью curl по доменному имени сервиса.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.


<details>
<summary>YAML Deployment и Service
</summary>

```task1
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: lesson3
  labels:
    app: nginx
spec:
  replicas: 1
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
            containerPort: 1180
---
apiVersion: v1
kind: Service
metadata:
  name: deployment-svc
  namespace: lesson3
spec:
  ports:
    - name: http-nginx
      port: 9001
      targetPort: http-nginx
    - name: http-multi
      port: 9002
      targetPort: http-multi
  selector:
    app: nginx
---
apiVersion: v1
kind: Pod
metadata:
  name: ext-multi
  namespace: lesson3
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

![screen](/screen/12-adminkube-04-1.png)

#

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера
1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.
2. Продемонстрировать доступ с помощью браузера или curl с локального компьютера.
3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.

<details>
<summary>YAML манифест и Service
</summary>

```task2
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: lesson3
  labels:
    app: nginx
spec:
  replicas: 1
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

---
apiVersion: v1
kind: Service
metadata:
  name: deployment-svc
  namespace: lesson3
spec:
  ports:
    - name: http-nginx
      port: 9001
      targetPort: http-nginx
      nodePort: 30007
  selector:
    app: nginx
  type: NodePort

```
</details>

![screen](/screen/12-adminkube-04-2.png)