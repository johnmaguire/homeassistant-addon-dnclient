ARG BUILD_FROM=definednet/dnclient:latest

# Extract binaries from official image (avoids inheriting its VOLUME declaration)
FROM ${BUILD_FROM} AS source

FROM alpine:3.21
RUN apk add --no-cache iptables ip6tables ca-certificates

COPY --from=source /usr/local/bin/dnclient /usr/local/bin/dnclient
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
