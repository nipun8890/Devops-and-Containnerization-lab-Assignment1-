FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app /app
