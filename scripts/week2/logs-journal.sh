#!/bin/bash

# Mostrar los últimos 20 logs del servicio pasado por parámetro
sudo journalctl -u $1 -n 20
