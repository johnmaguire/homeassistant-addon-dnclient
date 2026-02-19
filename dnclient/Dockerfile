ARG BUILD_FROM=definednet/dnclient:latest

# Extract dnclient binary from official image (avoids inheriting its VOLUME)
FROM ${BUILD_FROM} AS source

FROM alpine:3.21
RUN apk add --no-cache iptables ip6tables ca-certificates

COPY --from=source /usr/bin/dnclient /usr/bin/dnclient
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
