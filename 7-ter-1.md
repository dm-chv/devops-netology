### Чеклист
<hr>
* Скачайте и установите актуальную версию terraform   

![screen](/screen/7-ter-1-version.png)
<hr>
* Скачайте на свой ПК данный git репозиторий.
* Убедитесь, что в вашей ОС установлен docker.

![screen](/screen/7ter-1-dock-git.png)

<hr>

### Задание 1
1. Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.  
![screen](/screen/7ter-1-dock-git.png)
2. Изучите файл .gitignore. В каком terraform файле согласно этому .gitignore допустимо сохранить личную, секретную информацию?
<i>personal.auto.tfvars</i> 
3. Выполните код проекта. Найдите в State-файле секретное содержимое созданного ресурса random_password. Пришлите его в качестве ответа.  
![screen](/screen/7ter-1-State.png)
4. Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла main.tf. Выполните команду terraform validate. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.
* Первая ошибка - "All resource blocks must have 2 labels (type, name)" - в коде был указан только тип, добавил имя
* Вторая ошибка тут - image = docker_image.<b>nginx</b>.image_id то есть этот параметр должен быть равен имени образа(docker_image)
5. Выполните код. В качестве ответа приложите вывод команды docker ps

![screen](/screen/7ter-1-dockerPS.png)
6. Замените имя docker-контейнера в блоке кода на hello_world, выполните команду terraform apply -auto-approve. Объясните своими словами, в чем может быть опасность применения ключа -auto-approve ?

![screen](/screen/7ter-1-dockerRename.png)  
<i>Опасность заключается в том, что терраформ не показывает список изменений и не спрашивает подтверждения в таком режиме, соответственно можно случайно что-то уронить, ведь даже когда на автомате что-то делаешь, а тебя просят ввести "Да" ты в любом случае смотришь на экран(можешь что-то заметить) и есть дополнительная секунда для спасительной мысли "СТОЙ")) Миллион раз было такое, что ты в туже секунду, когда делаешь запуск - понимаешь, что есть косяк...</i>

7. Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.

![screen](/screen/7ter-1-destroy.png)  

8. Объясните, почему при этом не был удален docker образ nginx:latest ?(Ответ найдите в коде проекта или документации)
<i>переменную нашёл в коде, объяснение в документации на сайте терраформ</i>  
<b>keep_locally</b> (Boolean) If true, then the Docker image won't be deleted on destroy operation. 
If this is false, it will delete the image from the docker local storage on destroy operation.

<hr>

### Задание2*
* Создайте с его помощью любую виртуальную машину. Чтобы не использовать VPN советуем выбрать любой образ с расположением в github из списка

<i>Ниже на скрине разворачиваю инфраструктуру</i>  
![screen](/screen/7-ter-2-createVM.png)  

<i>Ниже на скрине показываю план и пингую виртуалку она работает</i>  
![screen](/screen/7-ter-2-mainPing.png)  

<i>Ниже показываю <b>"скриншот созданного в VB ресурса"</b></i>  
![screen](/screen/7-ter-2-VB.png)  
