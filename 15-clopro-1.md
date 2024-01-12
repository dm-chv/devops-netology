# Домашнее задание к занятию «Организация сети»

## Задание 1. Yandex Cloud
### Что нужно сделать

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
* Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
* Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
* Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.

3. Приватная подсеть.
* Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
* Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
* Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

#

<i>Демонстрация, что всё работает. слева в терминале открыт хост с внешним адресом, справа - хост только с внутренним</i>

![screen](/screen/15-clopro-1.png)

<details>
<summary>Конфиг генерации виртуальных машин

</summary>

```vm
 resource "yandex_compute_instance" "public-vm" {
    # depends_on = [ yandex_compute_instance.develop]
    for_each = {
      public = {cpu = 2, ram = 2, disk = 50}
      # second = {cpu = 4, ram = 8, disk = 10}
    }
    name        = "master-${each.key}"
    resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
  }
      boot_disk {
        initialize_params {
        image_id = var.mage-id
        type = "network-hdd"
       size = each.value.disk
    }
}
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = var.nat-instance-ip
    nat       = true
  }
    metadata = {
    serial-port-enable = 0
    user-data = "${file("cloud-config.yaml")}"
  }
}

resource "yandex_compute_instance" "private-vm" {
    # depends_on = [ yandex_compute_instance.develop]
    for_each = {
      private = {cpu = 2, ram = 2, disk = 50}
      # second = {cpu = 4, ram = 8, disk = 10}
    }
    name        = "master-${each.key}"
    resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
  }
      boot_disk {
        initialize_params {
        image_id = var.mage-id
        type = "network-hdd"
       size = each.value.disk
    }
}
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }
    metadata = {
    serial-port-enable = 0
    user-data = "${file("cloud-config.yaml")}"
  }
}
```
</details>

<details>
<summary>Конфиг network

</summary>

```curl
 resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  
}

resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.nat-route-table.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  
}

resource "yandex_vpc_route_table" "nat-route-table" {
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat-instance-ip
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_name
}

```
</details>

<details>
<summary>Конфиг variable

</summary>

```variable
 
variable "mage-id" {
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat-instance-ip" {
  default = "192.168.10.254"
}
```
</details>
