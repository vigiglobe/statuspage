FROM gliderlabs/alpine:3.3

# Install necessary CA certificates:
RUN apk --update upgrade && \
    apk add ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*

COPY ./dist/statuspage /usr/bin/statuspage

ENTRYPOINT ["/usr/bin/statuspage"]
CMD ["/bin/bash"]


