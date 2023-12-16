# Домашнее задание к занятию «Хранение в K8s. Часть 2»

## Создать Deployment приложения, использующего локальный PV, созданный вручную.

<details>
<summary>POD

</summary>

```task
apiVersion: v1
kind: Pod
metadata:
  name: pod-pv
  namespace: lesson6
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
      persistentVolumeClaim:
        claimName: pvc-manual
```
</details>

<details>
<summary>PV
</summary>

```task
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-manual
  namespace: lesson6
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 1Gi
  hostPath:
    path: /tmp/pv
  persistentVolumeReclaimPolicy: Deleteexit
```
</details>

<details>
<summary>PVC
</summary>

```task
apiVersion: v1 
kind: PersistentVolumeClaim
metadata:
  name: pvc-manual
  namespace: lesson6
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```
</details>

<i>Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории.</>
![screen](/screen/12-adminkube-07-1.png)

<i>Удалить Deployment и PVC. Продемонстрировать, что после этого произошло с PV. Пояснить, почему.</>
Ответ: PV самоудалился, т.к. он не используется и нет "заявки" на его создание(PVC)
![screen](/screen/12-adminkube-07-2.png)

<i>Продемонстрировать, что файл сохранился на локальном диске ноды. Удалить PV. Продемонстрировать что произошло с файлом после удаления PV. Пояснить, почему.</>
Ответ: На скрине демонстрация того, что файл виден на ноде
![screen](/screen/12-adminkube-07-3png)

Если мы удаляем PV при работающем поде, то консоль подвисает, ждет освобождения ресурсов, т.е. удаления пода и освобождения квоты(удаления PVC).  
После удаления пода и PVC удаляется PV, созданные файлы на ноде остаются.
![screen](/screen/12-adminkube-07-4png)

#

## Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

<details>
<summary>YAML file
</summary>

```task
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
  namespace: lesson6
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-nfs
  namespace: lesson6
spec:
  containers:
    - name: multitool
      image: wbitt/network-multitool
      volumeMounts:
        - mountPath: "/output"
          name: pvc
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: nfs-pvc 
```
</details>

<i>Продемонстрировать возможность чтения и записи файла изнутри пода</i>
![screen](/screen/12-adminkube-07-5.png)