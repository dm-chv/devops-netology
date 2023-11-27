# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 21»

## Задание 1. Создать Deployment приложений backend и frontend

<details>
<summary>YAML Deployment и Service
</summary>
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: lesson4
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

![screen](/screen/12-adminkube-05-1.png)

#

## Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

<details>
<summary>YAML Deployment и Service
</summary>
```
```
</details>

![screen](/screen/12-adminkube-05-2.png)

#