# Use the official n8n image as base
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /app

# Install pnpm globally
RUN npm install -g pnpm

# Copy dependency files first (for caching layers)
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --no-frozen-lockfile --prod=false

# Copy all source files
COPY . .

# Expose the n8n default port
EXPOSE 5678

# Start the application
CMD ["n8n"]
