#!/bin/bash

cat > /etc/profile.d/greendevcorp_env.sh << "EOF"
if id -nG "$USER" | grep -qw "greendevcorp"; then
	export PATH="$PATH:/home/greendevcorp/bin"
	alias task_list="cat /home/greendevcorp/done.log"
	alias shared_dir="cd /home/greendevcorp/shared"
fi
EOF
