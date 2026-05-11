FROM golang:1.26 AS builder
WORKDIR /app
COPY . .

COPY frontend ./frontend
COPY uploads ./uploads
RUN CGO_ENABLED=0 GOOS=linux go build -o app ./cmd/server

FROM alpine
WORKDIR /app
RUN apk add --no-cache ca-certificates
COPY --from=builder /app/app /app/app
COPY --from=builder /app/.env /app/.env
COPY --from=builder /app/frontend ./frontend
COPY --from=builder /app/uploads ./uploads
CMD ["./app"]
