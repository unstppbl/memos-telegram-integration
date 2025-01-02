# Build stage
FROM cgr.dev/chainguard/go:latest AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o memogram -mod vendor ./bin/memogram
RUN chmod +x memogram

# Run stage
FROM cgr.dev/chainguard/static:latest-glibc
WORKDIR /app
ENV SERVER_ADDR=dns:localhost:5230
ENV BOT_TOKEN=your_telegram_bot_token
COPY .env.example .env
COPY --from=builder /app/memogram .
CMD ["./memogram"]
