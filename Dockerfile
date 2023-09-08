FROM golang:alpine AS builder
WORKDIR /app
COPY main.go go.mod ./
RUN go build -o app
RUN go build -ldflags "-w -s" -o app
RUN go clean -cache
RUN go mod tidy

FROM scratch
WORKDIR /app
COPY --from=builder /app/app ./
ENTRYPOINT ["./app"]