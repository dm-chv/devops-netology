<hr>
<a href="https://github.com/dm-chv/ter-homeworks/tree/main/02/src">Ссылка на на ветку terraform-02 в моём репозитории </a> Задание выполненно так, как обычно, с скринами и описанием(в самом конце прочитал, что надо terr-src тоже выложить)
<hr>

### Задание 1
4. Инициализируйте проект, выполните код. Исправьте возникшую ошибку. Ответьте в чем заключается ее суть?

я сис админ со стажем, я умею читать)))  
в тексте ошибки содерджится ответ  
<code>
rpc error: code = InvalidArgument desc = the specified number of cores is not available on platform "standard-v1"; allowed core number: 2, 4
</code>
соответственно меняем количество ядер на 2 или 4, я выбрал 2 - так дешевле)  
<code>
cores         = 2
</code>
5. Ответьте, как в процессе обучения могут пригодиться параметры <code>preemptible = true </code>и <code>core_fraction=5</code> в параметрах ВМ?
<code>preemptible = true </code> - ВМ, которая работает не более 24 часов и может быть остановлена Compute Cloud в любой момент
<code>core_fraction=5</code> Гарантированная доля vCPU
<i>Соответсвенно эти параметры пригодятся нам для экономии бюджета, при использовании прерывания - цена ВМ падает примерно в два раза, при уменьшении % СПУ - тоже цена значительно падает</i>  

В качестве решения приложите:
* скриншот ЛК Yandex Cloud с созданной ВМ

![screen](/screen/7ter-2-1-cloud.png)

* скриншот успешного подключения к консоли ВМ через ssh,

![screen](/screen/7ter-2-1-ssh.png)

* ответы на вопросы. <i>(Дал в начале)</i>
<hr>

### Задание 2
* Замените все "хардкод" значения...

![screen](/screen/7ter-2-2.png)

### Задание 3

*Скопируйте блок ресурса и создайте с его помощью вторую ВМ(в файле main.tf): "netology-develop-platform-db" , cores = 2, memory = 2, core_fraction = 20. Объявите ее переменные с префиксом vm_db_ в том же файле('vms_platform.tf').  

![screen](/screen/7ter-2-3.png)

### Задание 4
* Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ.
* В качестве решения приложите вывод значений ip-адресов команды <b>terraform output</b>

![screen](/screen/7ter-2-4.png)

### Задание 5
1. В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с несколькими переменными по примеру из лекции.
2. Замените переменные с именами ВМ из файла variables.tf на созданные вами local переменные.
Примените изменения.

<i>Если я всё правильно понял, то так как-то надо было сделать....</i>

![screen](/screen/7ter-2-5.png)

### Задание 6
1. Вместо использования 3-х переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедените их в переменные типа map с именами "vm_web_resources" и "vm_db_resources".
<i><b>vms_platform.tf</b></i>
<code>
variable "vm_web_resources" {
    type=map
    default= {
    cpu =2
    ram = 1
    core_fraction = 5
    }
}
variable "vm_db_resources" {
    type=map
    default= {
    cpu =2
    ram = 2
    core_fraction = 20
}
}
</code>
<i><b>main.tf</b></i>
<code>
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id
    resources {
    cores         = var.vm_web_resources["cpu"]
    memory        = var.vm_web_resources["ram"]
    core_fraction = var.vm_web_resources["core_fraction"]
  }
#########################################
resource "yandex_compute_instance" "second_VM" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_resources["cpu"]
    memory        = var.vm_db_resources["ram"]
    core_fraction = var.vm_db_resources["core_fraction"]
  }
</code>
2. Так же поступите с блоком metadata {serial-port-enable, ssh-keys}, эта переменная должна быть общая для всех ваших ВМ.
<i><b>vms_platform.tf</b></i>
<code>
variable "metadata" {
  type=map
  default= {
  serialP = 1
  ssh = "ubuntu:/home/pixel/.ssh/id_rsa.pub"
  }
}
</code>
<i><b>main.tf</b></i>
<code>
  metadata = {
    serial-port-enable = var.metadata["serialP"]
    ssh-keys           = var.metadata["ssh"]
  }
</code>
3. Найдите и удалите все более не используемые переменные проекта.  
<i>Закомментировал всё лишнее...</i>
4. Проверьте terraform plan (изменений быть не должно).  
<i>Ok</i>
<code>
No changes. Your infrastructure matches the configuration.
Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
</code>

### Задание 7
1. Напишите, какой командой можно отобразить второй элемент списка test_list?  
<i>local.test_list[1]</i>
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).  
<i>length(local.test_list) </i>
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map ?  
<i>local.test_map["admin"]</i>
4. Напишите interpolation выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.  
<i>Я принцип пониманию(как это делается в других языках программирования), но как это сделать в консоле терраформа - я не нашёл примера синтаксиса, если поделитесь ссылкой - буду признателен.</i>