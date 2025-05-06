FROM golang:1.24.1-alpine AS builder

WORKDIR /listmonk
COPY . .

# Install build dependencies
RUN apk add --no-cache gcc musl-dev git

# Build the application
RUN go mod download
RUN go build -o listmonk cmd/main.go

FROM alpine:latest

WORKDIR /listmonk

# Copy the binary and necessary files
COPY --from=builder /listmonk/listmonk .
COPY --from=builder /listmonk/config.toml.sample config.toml
COPY --from=builder /listmonk/static static
COPY --from=builder /listmonk/frontend/dist frontend/dist
COPY --from=builder /listmonk/i18n i18n
COPY --from=builder /listmonk/schema.sql schema.sql
COPY --from=builder /listmonk/queries.sql queries.sql

# Create uploads directory
RUN mkdir -p uploads

EXPOSE 9000

# Use the same command as in docker-compose.yml
CMD ["./listmonk", "--install", "--idempotent", "--yes", "--config", "", "--upgrade", "--yes", "--config", "", "--config", ""] 