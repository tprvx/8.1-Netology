# Rsync - Petr

### Задание 1

```bash
sudo apt install rsync
rsync -a --progress . /tmp/backup --exclude '.*' --exclude 'Documents' --delete --checksum
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/Rsync/img/1.1.png?raw=true)

### Задание 2

```bash
nano create_backup.sh

#!/bin/bash

rsync -a --progress /home/vm9/ /tmp/backup --delete --checksum 2> /dev/null
if [ $? -eq 0 ]
then
	logger "Backup was successfully created"
else
	logger "Backup was successfully created"
fi

chmod 744 create_backup.sh

crontab -e
* 12 * * * /home/vm9/Documents/projects/Netology/create_backup.sh

crontab -l

sudo tail -n 10 /var/log/messages
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/Rsync/img/2.1.png?raw=true)