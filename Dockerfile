# syntax=docker/dockerfile:1

FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.* ./
RUN go mod download

COPY . ./

COPY *.go ./

RUN go build -v -o /prusa_exporter

FROM alpine:latest

COPY --from=builder /prusa_exporter .
COPY run.sh .

EXPOSE 10009

CMD [ "/run.sh" ]

#ENTRYPOINT ["/prusa_exporter"]
