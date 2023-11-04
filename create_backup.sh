#!/bin/bash

rsync -a --progress /home/vm9/ /tmp/backup --delete --checksum 2> /dev/null
if [ $? -eq 0 ]
then
	logger "Backup was successfully created"
else
	logger "Error when creating backup"
fi