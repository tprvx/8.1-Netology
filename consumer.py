#!/usr/bin/env python
# coding=utf-8

import pika

URI = 'amqp://user:pass@172.22.0.3:5672/'

params = pika.URLParameters(URI)
connection = pika.BlockingConnection(params)

channel = connection.channel()
channel.queue_declare(queue='hello')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume('hello', callback, auto_ack=True)
channel.start_consuming()