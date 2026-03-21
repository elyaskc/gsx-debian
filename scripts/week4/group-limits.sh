#!/bin/bash

LIMITS_FILE="/etc/security/limits.conf"

if ! grep -q "^@greendevcorp" "$LIMITS_FILE"; then
	cat >> "$LIMITS_FILE" << "EOF"

@greendevcorp	hard	nproc	50
@greendevcorp	hard	nofile	1024
@greendevcorp	hard	as	512000
@greendevcorp	hard	cpu	10
EOF
	echo "Límites actualizados"
else
	echo "Límites ya existentes"
fi
