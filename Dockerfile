FROM golang:alpine AS build
RUN mkdir /build
COPY src/* /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags='-extldflags "-static" -s -w' -o main .

FROM alpine
RUN mkdir -p /var/task
COPY --from=build /build/main /var/task/main
WORKDIR /var/task
ENTRYPOINT ["/var/task/main"]
