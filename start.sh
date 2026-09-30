#!/bin/bash
set -u

export PORT="8080"

export SM_USE_RISKY_OPEN="true"

while true; do
  /opt/sm/silvermoon
  echo "silvermoon exited ($?), restarting in 1s" >&2
  sleep 1
done

for _ in $(seq 1 30); do
  (exec 3<>/dev/tcp/127.0.0.1/9000) 2>/dev/null && break
  sleep 0.5
done

exec apache2ctl -D FOREGROUND