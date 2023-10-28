#!/bin/bash

if [[ "Ncat: Connected to 0.0.0.0:80." == $(nc -zv 0.0.0.0 80 2>&1 | grep Connected) ]] && [ -f /root/index.html ]; then
	exit 0
else
	exit 1
fi
