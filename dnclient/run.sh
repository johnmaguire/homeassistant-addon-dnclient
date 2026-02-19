#!/usr/bin/env sh
set -e

PERSIST_DIR="/data/defined"

# Ensure persistent directory exists and symlink /etc/defined to it
mkdir -p "${PERSIST_DIR}"
ln -sfn "${PERSIST_DIR}" /etc/defined

# Read enrollment code from HA options
ENROLLMENT_CODE="$(cat /data/options.json | sed -n 's/.*"enrollment_code" *: *"\([^"]*\)".*/\1/p')"

# Only set enrollment code if non-empty and host is not already enrolled
if [ -n "${ENROLLMENT_CODE}" ] && [ ! -f "${PERSIST_DIR}/config.yml" ]; then
    export DN_ENROLLMENT_CODE="${ENROLLMENT_CODE}"
    echo "Enrolling host with provided enrollment code..."
fi

echo "Starting dnclient..."
exec dnclient
