# Use official n8n base image
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /app

# Enable Corepack and install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Check if pnpm is installed correctly (Debugging Step)
RUN pnpm --version || npm --version

# Copy package.json and lockfile first
COPY package.json pnpm-lock.yaml ./

# Debug: Check if package files exist
RUN ls -la

# Install dependencies (Retry with npm if pnpm fails)
RUN if pnpm install --no-frozen-lockfile --prod=false; then echo "pnpm install success"; else npm install --omit=dev; fi

# Copy remaining files
COPY . .

# Expose n8n port
EXPOSE 5678

# Start n8n
CMD ["n8n"]
