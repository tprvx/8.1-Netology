# какое API используем
terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

# локальные переменные
locals {
    zone_a = "ru-central1-a"
}

# авторизация пользователя
provider "yandex" {
    token     = var.my_token
    cloud_id  = "b1g0b0v6u6g4ujsqt2k3"
    folder_id = "b1g7o5gbu8auje7uj2le"
}

resource "yandex_vpc_network" "network-1" {
    name = "network-1"
}
resource "yandex_vpc_subnet" "subnet-1" {
    name = "subnet1"
    zone = local.zone_a
    v4_cidr_blocks = ["192.168.10.0/24"]
    network_id = yandex_vpc_network.network-1.id
}

# создание двух одинаковых хостов
resource "yandex_compute_instance" "test-vm" {
    count = 2
    name = "test-vm${count.index}"
    platform_id = "standard-v2"
    zone = local.zone_a
    boot_disk {
        initialize_params {
            # debian 12
            image_id = "fd8e4mmbfidsqtqd7270"
            size     = 5
        }
    }
    resources {
        core_fraction = 5
        cores         = 2
        memory        = 2
    }
    network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
    }
    scheduling_policy {
        # прерываемая
        preemptible = false
    }
    metadata = {
        user-data = "${file("./meta.yaml")}"
    }
}

# создание группы хостов и добавление в нее
resource "yandex_lb_target_group" "test-1" {
  name = "test-1"
  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address = yandex_compute_instance.test-vm[0].network_interface.0.ip_address
  }
  target {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    address = yandex_compute_instance.test-vm[1].network_interface.0.ip_address
  }
}

# создание сетевого балансировщика для целевой группы хостов
resource "yandex_lb_network_load_balancer" "test-lb" {
  name = "test-lb"
  deletion_protection = false
  listener {
    name = "my-lb1"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.test-1.id
    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

# Создание диска снэпшота
resource "yandex_compute_snapshot" "snapshot-1" {
    name = "disk-snapshot-1"
    source_disk_id = "${yandex_compute_instance.test-vm[0].boot_disk[0].disk_id}"
}

# Создание снэпшотов по расписанию
resource "yandex_compute_snapshot_schedule" "default" {
    schedule_policy {
        expression = "0 0 * * *"
    }
    retention_period = "12h0m0s"

    snapshot_spec {
        description = "retention_snapshot"
    }
    disk_ids = ["${yandex_compute_instance.test-vm[0].boot_disk[0].disk_id}"]
}