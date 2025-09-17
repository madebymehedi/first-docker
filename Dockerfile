# ---- builder ----
FROM node:22-slim AS builder
WORKDIR /app
COPY package*.json tsconfig.json ./
RUN npm install
COPY . .
RUN npm run build

# ---- runner ----
FROM node:22-slim AS runner
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev
ENV NODE_ENV=production
EXPOSE 3000
CMD ["node", "dist/index.js"]
