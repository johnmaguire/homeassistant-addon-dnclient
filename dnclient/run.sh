#!/usr/bin/env sh
set -e

PERSIST_DIR="/data/defined"
SYSTEM_DIR="/etc/defined"

# Ensure persistent directory exists
mkdir -p "${PERSIST_DIR}"

# Restore persisted config if it exists
if [ -f "${PERSIST_DIR}/config.yml" ]; then
    cp -a "${PERSIST_DIR}/." "${SYSTEM_DIR}/"
    echo "Restored persisted dnclient config."
fi

# Read enrollment code from HA options
ENROLLMENT_CODE="$(cat /data/options.json | sed -n 's/.*"enrollment_code" *: *"\([^"]*\)".*/\1/p')"

# Only set enrollment code if non-empty and host is not already enrolled
if [ -n "${ENROLLMENT_CODE}" ] && [ ! -f "${SYSTEM_DIR}/config.yml" ]; then
    export DN_ENROLLMENT_CODE="${ENROLLMENT_CODE}"
    echo "Enrolling host with provided enrollment code..."
fi

# Persist config on shutdown
trap 'echo "Persisting config..."; cp -a "${SYSTEM_DIR}/." "${PERSIST_DIR}/"; exit 0' TERM INT

echo "Starting dnclient..."
dnclient &
DNCLIENT_PID=$!

# Wait a moment for enrollment to complete, then persist
sleep 5
cp -a "${SYSTEM_DIR}/." "${PERSIST_DIR}/" 2>/dev/null || true

wait ${DNCLIENT_PID}
