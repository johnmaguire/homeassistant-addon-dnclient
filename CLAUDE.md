# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Home Assistant add-on that runs Defined Networking's DNClient (Managed Nebula) on Home Assistant OS. It provides overlay network connectivity via a Nebula tun interface on the HA host.

## Architecture

This is a single-addon Home Assistant repository. All addon files live in `dnclient/`.

- **`dnclient/Dockerfile`** — Multi-stage build: extracts the `dnclient` binary from the official `definednet/dnclient:latest` image into a clean Alpine container (avoids inheriting the upstream image's VOLUME declaration which conflicts with HA data persistence).
- **`dnclient/run.sh`** — Entrypoint script. Creates tun device, symlinks `/etc/defined` → `/data/defined` for persistence, starts `dnclient run` in background, waits for control socket, enrolls if needed, then `wait`s on the background process.
- **`dnclient/config.yaml`** — HA addon metadata: declares `host_network: true`, `NET_ADMIN` privilege, and `enrollment_code` option.
- **`dnclient/build.yaml`** — Per-arch base image mapping (both amd64 and aarch64 use `definednet/dnclient:latest`).
- **`repository.json`** — HA add-on repository manifest.

## Key Design Decisions

- **Persistence**: `/data/defined/` is the persistent store (survives container restarts). `/etc/defined` is a symlink to it. The enrolled identity (`dnclient.yml`) lives there.
- **No VOLUME inheritance**: The upstream dnclient image declares a VOLUME which conflicts with HA's data directory mounting. The multi-stage build avoids this by copying only the binary.
- **Enrollment flow**: The enrollment code is read from `/data/options.json` (HA-provided). Enrollment only runs if `dnclient.yml` doesn't already exist.

## Building

There is no local build command — the addon is built by Home Assistant's addon build system. To test the Docker build manually:

```sh
docker build -t dnclient-addon dnclient/
```
