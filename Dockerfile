FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit-dev

COPY . .

FROM gcr.io/distroless/nodejs20-debian12

WORKDIR /app

COPY --from=builder /app ./

USER nonroot:nonroot

EXPOSE 3000

CMD ["index.js"]