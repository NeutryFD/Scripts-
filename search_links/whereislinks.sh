#!/bin/bash
ruta="$(find / -name $1 2>/dev/null | head -n 1)"
inumber="$(ls -lai $ruta | awk '{print $1}')"
find / -inum $inumber 2>/dev/null
echo 'i-node --> '$inumber
