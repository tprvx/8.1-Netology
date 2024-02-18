# Defence - Petr


### Задание 1

```Bash
sudo apt install ecryptfs-utils cryptsetup

sudo adduser cryptouser

su root

sudo ecryptfs-migrate-home -u cryptouser
```

**Чтобы расшифровать домашний каталог нужно авторизоваться именно с паролем этого пользователя, иначе файлы не расшифруются, даже если вход в каталог был с правами суперпользователя.**

![Задание 1.1](https://github.com/tprvx/Netology/blob/Defence/img/1.1.png?raw=true)
![Задание 1.2](https://github.com/tprvx/Netology/blob/Defence/img/1.2.png?raw=true)
![Задание 1.3](https://github.com/tprvx/Netology/blob/Defence/img/1.3.png?raw=true)


### Задание 2

Через GParted не смог почему то на вирт машине создать раздел 100 Мб, пошел другим путем, через интерфейс Virtual Box создал новый диск и уже так всё получилось

```Bash
sudo apt install gparted
sudo cryptsetup -y -v --type luks2 luksFormat /dev/sdb

sudo cryptsetup luksOpen /dev/sdb disk
ls /dev/mapper/disk

sudo dd if=/dev/zero of=/dev/mapper/disk
sudo mkfs.ext4 /dev/mapper/disk
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/Defence/img/2.1.png?raw=true)