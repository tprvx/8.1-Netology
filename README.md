# Yandex.Cloud: Load Balancer - Petr

### Задание 1

С помощью Terraform поднимаем в Yandex.Cloud 2 одинаковых хоста в одной подсети, добавляем их в общую целевую группу. Создаем сетевой балансировщик L3, на 80 порту балансируем трафик в этой целевой грумме хостов. Создаем диск для хранения снэпшотов. Создаем правило создания снэпшотов. 

```bash
terraform plan
terraform apply

ssh root@62.84.112.5 -i ./id-rsa

apt update
apt install nginx
nano /var/www/html/index.nginx-debian.html
systemctl status nginx

terraform destroy
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/Yandex_LB/img/1.1.png?raw=true)
![Задание 1.2](https://github.com/tprvx/Netology/blob/Yandex_LB/img/1.2.png?raw=true)
![Задание 1.3](https://github.com/tprvx/Netology/blob/Yandex_LB/img/1.3.png?raw=true)
![Задание 1.4](https://github.com/tprvx/Netology/blob/Yandex_LB/img/1.4.png?raw=true)
