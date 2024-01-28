#!/usr/bin/env python
# coding=utf-8

import pika

URI = 'amqp://user:pass@172.22.0.2:5672/'

params = pika.URLParameters(URI)
connection = pika.BlockingConnection(params)

channel = connection.channel()
channel.queue_declare(queue='hello')
channel.basic_publish(exchange='', routing_key='hello', body='Hello Netology!')
connection.close()