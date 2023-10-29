# Nginx и HAProxy - Petr

### Задание 1 - HAProxy

L4 Балансировка с использованием только HAProxy

```bash
mkdir http1 http2
cd http1
nano index.html
cd ../http2
nano index.html

python3 -m http.server 9999 --bind 0.0.0.0
cd ../http1
python3 -m http.server 8888 --bind 0.0.0.0

curl http://localhost:8888
curl http://localhost:9999

sudo apt install haproxy -y

sudo nano /etc/haproxy/haproxy.cfg

sudo systemctl reload haproxy.service
sudo systemctl status haproxy.service

# проверка L4 балансировки HAProxy
curl http://127.0.0.1:8088
```

Файл /etc/haproxy/haproxy.cfg:
```bash
global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
	errorfile 400 /etc/haproxy/errors/400.http
	errorfile 403 /etc/haproxy/errors/403.http
	errorfile 408 /etc/haproxy/errors/408.http
	errorfile 500 /etc/haproxy/errors/500.http
	errorfile 502 /etc/haproxy/errors/502.http
	errorfile 503 /etc/haproxy/errors/503.http
	errorfile 504 /etc/haproxy/errors/504.http

listen stats
	bind :888
	mode http
	stats enable
	stats uri /stats
	stats refresh 5s

frontend example
	mode http 
	bind :8088
	default_backend web_servers

backend web_servers
	mode http
	balance roundrobin
	option httpchk
	http-check send meth GET uri /index.html
	server s1 127.0.0.1:8888 check
	server s2 127.0.0.1:9999 check
```

![Задание 1.1](https://github.com/tprvx/Netology-Homeworks/blob/Nginx-HAProxy/img/1.1.png?raw=true)

![Задание 1.2](https://github.com/tprvx/Netology-Homeworks/blob/Nginx-HAProxy/img/1.2.png?raw=true)


### Задание 2

L7 Балансировка с использованием только HAProxy

```bash
mkdir http3
cd http3
nano index.html

python3 -m http.server 7777 --bind 0.0.0.0
curl http://localhost:7777

sudo nano /etc/haproxy/haproxy.cfg

sudo systemctl reload haproxy.service
sudo systemctl status haproxy.service

# проверка L7 балансировки HAProxy
curl -H 'Host: example.local' http://127.0.0.1
curl http://127.0.0.1
curl http://127.0.0.1:8088
```

Файл /etc/haproxy/haproxy.cfg:
```bash
global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
	errorfile 400 /etc/haproxy/errors/400.http
	errorfile 403 /etc/haproxy/errors/403.http
	errorfile 408 /etc/haproxy/errors/408.http
	errorfile 500 /etc/haproxy/errors/500.http
	errorfile 502 /etc/haproxy/errors/502.http
	errorfile 503 /etc/haproxy/errors/503.http
	errorfile 504 /etc/haproxy/errors/504.http

listen stats
	bind :888
	mode http
	stats enable
	stats uri /stats
	stats refresh 5s

frontend example
	mode http 
	bind :80
	acl ACL_example.local hdr(host) -i example.local
	use_backend web_servers if ACL_example.local

backend web_servers
	mode http
	balance roundrobin
	option httpchk
	http-check send meth GET uri /index.html
	server s1 127.0.0.1:8888 weight 2 check inter 3s
	server s2 127.0.0.1:9999 weight 3 check inter 3s
	server s3 127.0.0.1:7777 weight 4 check inter 3s
```

![Задание 2.1](https://github.com/tprvx/Netology-Homeworks/blob/Nginx-HAProxy/img/2.1.png?raw=true)

![Задание 2.2](https://github.com/tprvx/Netology-Homeworks/blob/Nginx-HAProxy/img/2.2.png?raw=true)

![Задание 2.3](https://github.com/tprvx/Netology-Homeworks/blob/Nginx-HAProxy/img/2.3.png?raw=true)

### Задание 3*

Балансировка Nginx + HAProxy

Файл /etc/nginx/nginx.conf
```bash
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
}

http {

	sendfile on;
	tcp_nopush on;
	types_hash_max_size 2048;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; 
	ssl_prefer_server_ciphers on;

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	gzip on;

	server {
		listen 80 default_server;
		listen [::]:80 default_server;

		server_name _;

		location ~* ^.+\.(jpg) {
	        root /var/www/img;
	    }

		location / {
			try_files $uri $uri/ /?$args;
			proxy_pass  http://localhost:1325;
		}
	}
}

```

Файл /etc/haproxy/haproxy.cfg
```
global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets

defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
	errorfile 400 /etc/haproxy/errors/400.http
	errorfile 403 /etc/haproxy/errors/403.http
	errorfile 408 /etc/haproxy/errors/408.http
	errorfile 500 /etc/haproxy/errors/500.http
	errorfile 502 /etc/haproxy/errors/502.http
	errorfile 503 /etc/haproxy/errors/503.http
	errorfile 504 /etc/haproxy/errors/504.http

listen stats
	bind :888
	mode http
	stats enable
	stats uri /stats
	stats refresh 5s

frontend example
	mode http 
	bind :1325
	default_backend web_servers

backend web_servers
	mode http
	balance roundrobin
	option httpchk
	http-check send meth GET uri /index.html
	server s1 127.0.0.1:8888 weight 13 check inter 3s
	server s2 127.0.0.1:9999 weight 17 check inter 3s
```

![Задание 3.1](https://github.com/tprvx/Netology-Homeworks/blob/Nginx-HAProxy/img/2.4.png?raw=true)
