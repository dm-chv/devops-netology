# Домашнее задание к занятию «Сетевое взаимодействие в K8S. Часть 21»

## Задание 1. Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными.

<details>
<summary>YAML file
</summary>

```task
apiVersion: v1
kind: Pod
metadata:
  name: pod-dir
  namespace: lesson5
spec:
  containers:
    - name: busybox
      image: busybox
      command: ["sleep", "3600"]
      volumeMounts:
        - mountPath: "/input"
          name: my-volume
    - name: multitool
      image: wbitt/network-multitool
      volumeMounts:
        - mountPath: "/output"
          name: my-volume
  volumes:
    - name: my-volume
      emptyDir: {}
```
</details>
<i>В целом по лекции + не хитрый скрипт записи в файл</i>
![screen](/screen/12-adminkub-06-1.png)

## Задание 1. Создать DaemonSet приложения, которое может прочитать логи ноды.

<details>
<summary>YAML file
</summary>

```task
apiVersion: v1
kind: Pod
metadata:
  name: task2
  namespace: lesson5
spec:
  containers:
    - name: multitool
      image: wbitt/network-multitool
      volumeMounts:
        - mountPath: "/share"
          name: my-volume
  volumes:
    - name: my-volume
      hostPath:
        path: /var/log
```
</details>

![screen](/screen/12-adminkub-06-2.png)