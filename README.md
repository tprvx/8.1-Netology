# Система мониторинга Zabbix - Часть 2 - Petr

### UserParametr Zabbix

```
# Регистрируем свой UserParametr
sudo find / -name zabbix_agentd.conf
UserParameter=template_echo[*], echo $1, $2
DebugLevel=5
systemctl restart zabbix-agent.service
systemctl status zabbix-agent.service

# Утилита позволяет минуя zabbix-server работать с zabbix-agent, даже с самого агента
sudo apt install zabbix-get
zabbix_get -s 127.0.0.1 -p 10050 -k "system.cpu.load[all,avg1]"
zabbix_get -s 127.0.0.1 -p 10050 -k "template_echo[123]"
123

cat /var/log/zabbix/zabbix_agentd.log | grep echo
```

nano /etc/zabbix/zabbix_agentd.d/test_user_parameter.py:
```python
import sys
import os
import re

if (sys.argv[1] == '-ping'):
    result = os.popen("ping -c 1 " + sys.argv[2]).read()
    result = re.findall(r"time=(.*) ms", result)
    print(result[0])
elif (sys.argv[1] == '-simple_print'):
    print(sys.argv[2])
else:
    print(f"unknown input: {sys.argv[1]}")
```

nano /etc/zabbix/zabbix_agentd.d/test_user_parameter.conf:
```
UserParameter=custom_py_ping[*], python3 /etc/zabbix/zabbix_agentd.d/test_user_parameter.py -ping $1
UserParameter=custom_py_print[*], python3 /etc/zabbix/zabbix_agentd.d/test_user_parameter.py -print $1
UserParameter=custom_py_script[*], python3 /etc/zabbix/zabbix_agentd.d/test_user_parameter.py -script $1

```

```
zabbix_get -s 127.0.0.1 -p 10050 -k "custom_py_ping[8.8.8.8]"
```

### Задание 1

![Задание 1](https://github.com/tprvx/Netology-Homeworks/blob/8.6-Netology/img_homework/1.png?raw=true)

### Задание 2-3

![Задание 2-3](https://github.com/tprvx/Netology-Homeworks/blob/8.6-Netology/img_homework/2-3.png?raw=true)

### Задание 4

![Задание 4](https://github.com/tprvx/Netology-Homeworks/blob/8.6-Netology/img_homework/4.png?raw=true)

### Задание* 5

![Задание 5](https://github.com/tprvx/Netology-Homeworks/blob/8.6-Netology/img_homework/5.png?raw=true)

### Задание* 8

![Задание 8](https://github.com/tprvx/Netology-Homeworks/blob/8.6-Netology/img_homework/8.png?raw=true)