#!/bin/bash
set -eu

export PORT="${PORT:-8080}"

export SM_USE_RISKY_OPEN="true"

export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data

mkdir -p "$APACHE_RUN_DIR" "$APACHE_LOCK_DIR"

sed -i "s/^Listen .*/Listen ${PORT}/" /etc/apache2/ports.conf

echo "Starting Silvermoon..." >&2

/opt/sm/silvermoon &
SM_PID=$!

echo "Silvermoon started with PID $SM_PID" >&2

echo "Waiting for Silvermoon on port 9000..." >&2

for _ in $(seq 1 30); do
    if (exec 3<>/dev/tcp/127.0.0.1/9000) 2>/dev/null; then
        exec 3>&-
        echo "Silvermoon is ready." >&2
        break
    fi

    sleep 0.5
done

if ! kill -0 "$SM_PID" 2>/dev/null; then
    echo "Silvermoon exited before Apache could start." >&2
    wait "$SM_PID"
fi

echo "Starting Apache on port ${PORT}..." >&2

exec apache2 -D FOREGROUND
