FROM golang:1.13-stretch as builder
WORKDIR /src
COPY . .
RUN make docker-authz-plugin

FROM scratch
COPY --from=builder /src/docker-authz-plugin /bin/docker-authz-plugin

ENTRYPOINT [ "/bin/docker-authz-plugin" ]