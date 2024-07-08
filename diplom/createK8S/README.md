# Скрипт разворачивания кластера K8S на Yandex Cloud

## Краткое описание

* Данный скрипт для Terraform разворачивает заданное количество c заданными параметрами VPC на Yandex Cloud.
* После поднятия VPC создается файл ```/inventory/hosts.yml``` по шаблону ```hosts.tftpl``` для Ansible
* Далее запускаем ansible-playbook для подготовки серверов (ip адреса и роль серверов берется из созданного выше файла)    
```ansible-playbook -i inventory/hosts.yml site.yml```

# 

<b>personal.auto.tfvars</b> - указываем параметры подключения к Яндекс облаку  
<b>cloud-config.yaml</b> - SSH ключи и логин для подключения к VPC  
<b>security.tf</b> - настройка security групп  
<b>vm-master.tf</b> - Конфигурация VPC для мастер ноды  
<b>vm-worker.tf</b> - Конфигурация VPC для воркер ноды  
<b>backet.tf</b> - Создание бакета  
<b>site.yml</b> - Запускаем Ансибл, он настраивает мастер и воркер ноды, из переменных в inventory, подключает все воркер ноды  

#

<p>Разворачивание ифраструктыру</p>

```
terraform init
terraform plan
terraform apply
```
<p>Запуск плейбука ansible для разворачивания кластера K8S (IaaC)</p>

```
ansible-playbook -i inventory/hosts.yml site.yml --ssh-common-args='-o StrictHostKeyChecking=no' -u ubuntu
```
<p>Удалить все созданные ресурсы</p>

```
terraform destroy
```
