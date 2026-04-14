FROM golang:1.21-alpine as builder

WORKDIR /app
COPY main.go go.mod ./
RUN go mod tidy
RUN go build -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates curl postgresql-client
WORKDIR /app
COPY --from=builder /app/app .
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 8080
CMD ["./app"]
