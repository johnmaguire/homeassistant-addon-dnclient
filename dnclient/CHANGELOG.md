# Changelog

## 0.9.7 (2026-07-30)

- Update dnclient to 0.9.7

## 0.9.5 (2026-06-04)

- Update dnclient to 0.9.5

## 0.9.4.1 (2026-06-02)

- Fix enrollment hang on dnclient 0.9.x: pin `DNCLIENT_STATE_DIR=/etc/defined`
  and `DNCLIENT_SOCKET_DIR=/var/run` in the Dockerfile. dnclient 0.9.x moved its
  Linux defaults to `/var/lib/defined` and `/var/run/defined`, so the control
  socket no longer appeared at `/var/run/dnclient.sock` and `run.sh` timed out
  waiting for it.

## 0.9.4 (2026-05-29)

- Update dnclient to 0.9.4

## 0.9.3 (2026-05-01)

- Update dnclient to 0.9.3

## 0.9.2 (2026-04-18)

- Update dnclient to 0.9.2

## 0.9.1 (2026-03-28)

- Update dnclient to 0.9.1

## 0.1.0

- Initial release
- Runs dnclient with host networking and NET_ADMIN capability
- Persistent enrollment across restarts
- Supports amd64 and aarch64
