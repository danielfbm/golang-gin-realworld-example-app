FROM golang:1.15-buster as builder

WORKDIR /go/src/app

COPY . /go/src/app

RUN go build -o app . && chmod +x ./app

FROM debian:buster

ENV DB_PATH=/app/db
ENTRYPOINT [ "/app/app" ]

RUN apt-get update \
  && apt-get install sqlite -y \
  && mkdir -p /app/db

COPY --from=builder /go/src/app/app /app/app