# Домашнее задание к занятию Troubleshooting

## Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

1. Установить приложение по команде:
```commandline
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
2. Выявить проблему и описать.
3. Исправить проблему, описать, что сделано.
4. Продемонстрировать, что проблема решена.

#

Проблема в том, что эти поды в разных неймспесах, если использовать польное FQDN имя, то всё работает

подключаемся к любому поду, что бы узнать полное DNS имя
```commandline
kubectl -n web exec -ti deployments/web-consumer sh
nslookup anyName
Server:    10.152.183.10
Address 1: 10.152.183.10 kube-dns.kube-system.svc.cluster.local
```
получаем FQDN адрес DNS сервера и соответснно наш будет иметь вид "auth-db.data.svc.cluster.local"
делаем curl на этот адрес, всё работает
<details>
<summary>kubectl -n web exec deployments/web-consumer -- curl auth-db.data.svc.cluster.local:80

</summary>

```curl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0   539k      0 --:--:-- --:--:-- --:--:--  597k
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
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
```
</details>

меняем соответсвующую команду в конфиге, приложение работает
```commandline
while true; do curl auth-db.data.svc.cluster.local; sleep 5; done
```