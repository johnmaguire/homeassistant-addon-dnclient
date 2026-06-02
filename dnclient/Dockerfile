ARG BUILD_FROM

# Extract binaries from official image (avoids inheriting its VOLUME declaration)
FROM ${BUILD_FROM} AS source

FROM alpine:3.21
RUN apk add --no-cache iptables ip6tables ca-certificates

COPY --from=source /usr/local/bin/dnclient /usr/local/bin/dnclient
COPY run.sh /
RUN chmod a+x /run.sh

# dnclient 0.9.x moved its Linux defaults to /var/lib/defined (state) and
# /var/run/defined (socket). Pin the legacy paths so the socket lands at
# /var/run/dnclient.sock and state at /etc/defined (symlinked to /data/defined
# in run.sh), matching what run.sh waits for and persists. Without these the
# multi-stage build — which copies only the binary — loses the env vars the
# upstream image sets, and run.sh times out waiting for the control socket.
ENV DNCLIENT_STATE_DIR=/etc/defined \
    DNCLIENT_SOCKET_DIR=/var/run

CMD [ "/run.sh" ]
