resource "yandex_compute_instance" "develop" {
    count = 2
    name        = "worker-${count.index}"
    resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
    boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = 100
    }
  }
  scheduling_policy {
    preemptible = true
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
