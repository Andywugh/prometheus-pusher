ARG PUSHER_VERSION=0.1.0

FROM golang:1.10-alpine3.7 AS build_go

COPY ./prometheus-pusher /go/src/github.com/yunlzheng/prometheus-pusher
WORKDIR /go/src/github.com/yunlzheng/prometheus-pusher
RUN go build .

FROM golang:1.10-alpine3.7 AS dist
ARG PUSHER_VERSION
ENV PUSHER_VERSION=${PUSHER_VERSION}
EXPOSE 9300
COPY --from=build_go /go/src/github.com/yunlzheng/prometheus-pusher/prometheus-pusher /prometheus-pusher
COPY ./prometheus-pusher/entrypoint.sh /entrypoint.sh
WORKDIR /
CMD ["./prometheus-pusher"]

