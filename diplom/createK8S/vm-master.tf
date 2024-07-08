resource "yandex_compute_instance" "web" {
    for_each = {
      first = {cpu = 2, ram = 2, disk = 50}
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
        image_id = data.yandex_compute_image.ubuntu.image_id
        type = "network-hdd"
       size = each.value.disk
    }
}
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
    metadata = {
    serial-port-enable = 0
    user-data = "${file("cloud-config.yaml")}"
  }
}
