#!/bin/sh
set -euo pipefail

PERSIST_DIR="/data/defined"
SYSTEM_DIR="/etc/defined"
CONTROL_SOCKET="/var/run/dnclient.sock"

# Ensure persistent directory exists and symlink /etc/defined to it
mkdir -p "${PERSIST_DIR}"
ln -sfn "${PERSIST_DIR}" "${SYSTEM_DIR}"

# Create the tun device so it doesn't need to be mounted
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

# Read enrollment code from HA options
ENROLLMENT_CODE="$(sed -n 's/.*"enrollment_code" *: *"\([^"]*\)".*/\1/p' /data/options.json)"

# Start dnclient
dnclient run -server "${DN_API_SERVER:-https://api.defined.net}" &

# Wait for control socket
for i in $(seq 1 11); do
    if [ -S "$CONTROL_SOCKET" ]; then
        break
    fi
    if [ "$i" -eq 11 ]; then
        echo "Timed out waiting for dnclient."
        exit 1
    fi
    echo "Waiting for dnclient $CONTROL_SOCKET ($i/10)..."
    sleep 1
done

# Enroll if not already enrolled
if [ ! -f "${PERSIST_DIR}/dnclient.yml" ]; then
    if [ -z "${ENROLLMENT_CODE}" ]; then
        echo "Please provide an enrollment code in the add-on configuration."
        exit 1
    fi
    export DN_ENROLLMENT_CODE="${ENROLLMENT_CODE}"
    if ! dnclient enroll -code "$DN_ENROLLMENT_CODE"; then
        echo "Enrollment failed."
        exit 1
    fi
    echo "Enrollment complete."
fi

wait
