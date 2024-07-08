# diplomanetology

## Что необходимо для сдачи задания?
## 1. Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.  
[createK8S](https://github.com/dm-chv/devops-netology/tree/main/diplom/createK8S)
    
## 2. Пример pull request с комментариями созданными atlantis'ом или снимки экрана из Terraform Cloud или вашего CI-CD-terraform pipeline.

* я тут сделал всё по класике и максимально автоматизировал.  

* Terraform разворачивает заданное количество c заданными параметрами VPC на Yandex Cloud.  
* После поднятия VPC создается файл ```/inventory/hosts.yml``` по шаблону ```hosts.tftpl``` для Ansible  
* Далее запускаем ansible-playbook для подготовки серверов (ip адреса и роль серверов берется из созданного выше файла)  
```ansible-playbook -i inventory/hosts.yml site.yml -u ubuntu```  

![screen](/diplom/screenshots/diploma-backet.png)
![screen](/diplom/screenshots/diploma-master.png)
![screen](/diplom/screenshots/diploma-template.png)
![screen](/diplom/screenshots/diploma-worker.png)

## 3. Репозиторий с конфигурацией ansible, если был выбран способ создания Kubernetes кластера при помощи ansible.
[ansible](https://github.com/dm-chv/devops-netology/tree/main/diplom/createK8S/site.yml)  
<i> не большой скрин для наглядности</i>  
![screen](/diplom/screenshots/diploma-ansible.png)

## 4. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.
[ansible](https://github.com/dm-chv/devops-netology/tree/main/diplom/test-app/Dockerfile)  
[DockerHub](https://hub.docker.com/repository/docker/chaltsev/simpleapp/general)  

## 5. Репозиторий с конфигурацией Kubernetes кластера.
[config k8s](https://github.com/dm-chv/devops-netology/tree/main//diplom/createK8S/ansible-k8s-monitoring-and-test-app.yml)

## 6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.
 
[grafana:](http://158.160.114.185:30003)  
    admin:LrR>MG,7T?>uNKy
![screen](/diplom/screenshots/diploma-grafana.png)

    test-app:
[test-app:](http://158.160.114.185:30004) 
![screen](/diplom/screenshots/diploma-kub-app.png)