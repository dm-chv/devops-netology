### Задание 1
<i>Опишите основные преимущества применения на практике IaaC-паттернов.</i>
* Скорость и уменьшение затрат

<i>Какой из принципов IaaC является основополагающим?</i>
* Идемпотентность -  это свойство объекта
или операции, при повторном выполнении
которой мы получаем результат идентичный
предыдущему и всем последующим
выполнениям

### Задание 2
<i>Чем Ansible выгодно отличается от других систем управление конфигурациями?</i>
* простота, низкий порог входа

</i>Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?</i>
* Push, так как все конфигурации хранятся локально.

### Задание 3
<i>Установите на личный компьютер:
VirtualBox,
Vagrant,
Terraform,
Ansible.</i>

<code> 
vboxmanage --version

6.1.38_Ubuntur153438  
</code>    

<code>vagrant --version  
Vagrant 2.3.4
</code> 

<code>terraform -version  
Terraform v1.4.2  
on linux_amd64  
</code>

<code>
ansible --version  
ansible 2.10.8  
</code>


### Задание 4
<i>Воспроизведите практическую часть лекции самостоятельно.</i>  
* Создайте виртуальную машину.
> это мы делали в прошлом модуле, повторил  
>vagrant box list  
../focal-server-cloudimg-amd64-vagrant.box          (virtualbox, 0)  
/home/pixel/focal-server-cloudimg-amd64-vagrant.box (virtualbox, 0)  


* Зайдите внутрь ВМ, убедитесь, что Docker установлен с помощью команды docker ps,  
> docker ps  
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES  
docker version  
erver: Docker Engine - Community  
 Engine:  
  Version:          23.0.1  
<hr>

### отличное задание, разобрался!  
