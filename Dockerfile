FROM node:22.13.1-alpine AS builder

# Set working directory
WORKDIR /app

# Copy application files 
COPY packages/ ./packages
COPY pnpm-workspace.yaml ./
COPY apps/builder/ ./

# Install dependencies
RUN corepack enable && corepack prepare pnpm@latest --activate
RUN pnpm install

# Build the application (if needed, adjust accordingly)
RUN pnpm run build

# -- Second Stage: Production Image --
FROM node:22.13.1-alpine AS production

# Set working directory
WORKDIR /app

# Copy only necessary files from builder stage
COPY --from=builder /app .

# Expose necessary port
EXPOSE 13100

# Set entry point
CMD ["npx", "remix-serve", "build/server/index.js"]