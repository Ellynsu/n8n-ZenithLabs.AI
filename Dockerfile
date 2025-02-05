# Use official n8n image as the base
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /app

# Ensure the correct package manager is installed
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install dependencies without using frozen lockfile
RUN pnpm install --no-frozen-lockfile --prod=false

# Copy all source files
COPY . .

# Expose the n8n default port
EXPOSE 5678

# Start n8n
CMD ["n8n"]
