ARG BUILD_FROM=definednet/dnclient:latest
FROM ${BUILD_FROM}

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
