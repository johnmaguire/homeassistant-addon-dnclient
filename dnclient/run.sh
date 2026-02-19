#!/usr/bin/env sh
set -e

CONFIG_DIR="/data/defined"
SYSTEM_DIR="/etc/defined"

# Ensure persistent config directory exists
mkdir -p "${CONFIG_DIR}"

# Symlink /etc/defined -> /data/defined for persistence across restarts
if [ ! -L "${SYSTEM_DIR}" ]; then
    rm -rf "${SYSTEM_DIR}"
    ln -s "${CONFIG_DIR}" "${SYSTEM_DIR}"
fi

# Read enrollment code from HA options
ENROLLMENT_CODE="$(cat /data/options.json | sed -n 's/.*"enrollment_code" *: *"\([^"]*\)".*/\1/p')"

# Only set enrollment code if non-empty and host is not already enrolled
if [ -n "${ENROLLMENT_CODE}" ] && [ ! -f "${CONFIG_DIR}/config.yml" ]; then
    export DN_ENROLLMENT_CODE="${ENROLLMENT_CODE}"
    echo "Enrolling host with provided enrollment code..."
fi

echo "Starting dnclient..."
exec dnclient
