#!/bin/sh
# ./test.sh [base-url]  -> kiểm tra chọn đúng dev/prod + old/new (example-app, newFromVersion=105)
B=${1:-https://remote-config.vantuan8802.workers.dev}
chk() { got=$(curl -si "$B/config/example-app?$1" | tr -d '\r' | awk -F': ' 'tolower($1)=="x-config-variant"{print $2}')
  [ "$got" = "$2" ] && echo "ok   $1 -> $got" || { echo "FAIL $1 -> '$got' (want $2)"; exit 1; }; }
chk "env=dev&version=104"  dev.old
chk "env=dev&version=105"  dev.new
chk "env=prod&version=104" prod.old
chk "env=prod&version=200" prod.new
chk "version=200"          prod.new
