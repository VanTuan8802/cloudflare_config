#!/bin/sh
# ./push.sh example-app -> đẩy mọi apps/example-app/*.json lên KV (key = example-app:<tên file>)
for f in "apps/$1"/*.json; do
  npx wrangler kv key put "$1:$(basename "$f" .json)" --path "$f" --binding CONFIG --remote
done
