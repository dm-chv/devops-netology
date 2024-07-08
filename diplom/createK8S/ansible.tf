resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
       masterservers =  yandex_compute_instance.web
       workerservers = yandex_compute_instance.develop
    }
  )
  filename = "${abspath(path.module)}/inventory/hosts.yml"
}