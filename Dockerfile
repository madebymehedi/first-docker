# ---- builder ----
FROM node:lts-slim AS builder
WORKDIR /app
COPY package*.json pnpm-lock.yaml tsconfig.json ./
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build

# ---- runner ----
FROM node:lts-slim AS runner
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/pnpm-lock.yaml ./
RUN corepack enable && pnpm install --prod --frozen-lockfile
ENV NODE_ENV=production
EXPOSE 3000
CMD ["node", "dist/index.js"]
