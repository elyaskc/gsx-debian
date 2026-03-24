#!/bin/bash

sudo groupadd -f greendevcorp

for dev in $@ ; do
	if ! getent passwd "$dev"; then
		sudo useradd -m -s /bin/bash $dev
	fi
	sudo usermod -aG greendevcorp $dev
done
