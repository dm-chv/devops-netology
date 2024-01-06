# Домашнее задание к занятию «Kubernetes. Причины появления. Команда kubectl»

#

## Цель задания

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине или на отдельной виртуальной машине MicroK8S.

#

## Задание 1. Установка MicroK8S

* Установить MicroK8S на локальную машину или на удалённую виртуальную машину.
```commandline
sudo snap install mikrok8s --classic
```
* Установить dashboard.
```commandline
sudo microk8s enable dashboard
sudo microk8s status
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dashboard            # (core) The Kubernetes dashboard
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
    metrics-server       # (core) K8s Metrics Server for API access to service metrics

```
* Сгенерировать сертификат для подключения к внешнему ip-адресу.
<details>
<summary>sudo token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1) microk8s kubectl -n kube-system describe secret $token
</summary>

```commandline
sudo token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1) microk8s kubectl -n kube-system describe secret $token
Insufficient permissions to access MicroK8s.
You can either try again with sudo or add the user pixel to the 'microk8s' group:

    sudo usermod -a -G microk8s pixel
    sudo chown -R pixel ~/.kube

After this, reload the user groups either via a reboot or by running 'newgrp microk8s'.
Name:         kubernetes-dashboard-certs
Namespace:    kube-system
Labels:       k8s-app=kubernetes-dashboard
Annotations:  <none>

Type:  Opaque

Data
====


Name:         microk8s-dashboard-token
Namespace:    kube-system
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 48db5f80-e8ee-4e3a-a80e-5471a857b889

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1123 bytes
namespace:  11 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IkYtWkI3bVZ0MGRCV2hIYTNMMHo5Zkhod2o5d0tCdmJhQ0RSUW5qZngzYmMifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtaWNyb2s4cy1kYXNoYm9hcmQtdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjQ4ZGI1ZjgwLWU4ZWUtNGUzYS1hODBlLTU0NzFhODU3Yjg4OSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpkZWZhdWx0In0.lvF4t_oFb36mIpPMTTC_ekEqkDK6WnuuBNY4bM7fVsfGXON9hUAnDQ3BKqG_YP96SfJ4ntAXwfCiZTDbRqYYRlBGUUL6bTmfeg_UB_l4SLTGE-x_mE3itfC0GVn1vIS5hE6Puc6zp5ExICR0b-SAaZ5vgFR2dzASedCX5VASVl68FIK5O-JUihjp5lxsdXBFoy_6ySna2o5L-2MKuAh7APvC9pnMGT9nSDBkMGdoxwuMk2a2RHBl8ez6iaS8vESW0o_ml43HLwYfmgku5OLJj2n3807hkZ2BfdxJ-dLqFk1jwrYqEQtd4aYmERKcTnVc4VDBNSnSAe7tKFvBgFEqIw


Name:         kubernetes-dashboard-csrf
Namespace:    kube-system
Labels:       k8s-app=kubernetes-dashboard
Annotations:  <none>

Type:  Opaque

Data
====
csrf:  256 bytes


Name:         kubernetes-dashboard-key-holder
Namespace:    kube-system
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
pub:   459 bytes
priv:  1675 bytes

```

</details>

### Задание 2. Установка и настройка локального kubectl
* Установить на локальную машину kubectl.
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
```
* Настроить локально подключение к кластеру.
```commandline
kubectl config use-context microk8s
Switched to context "microk8s"
```
* Подключиться к дашборду с помощью port-forward.
![screen](/screen/12-adminkube-01.png)