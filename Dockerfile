# Use Node 20 (required for Strapi v5)
FROM node:20-bullseye-slim

WORKDIR /app

# Install basic tools
RUN apt-get update && \
    apt-get install -y python3 build-essential g++ curl git && \
    rm -rf /var/lib/apt/lists/*

# Copy package files
COPY my-app/package*.json ./

# Install dependencies (all)
RUN npm install

# Copy the rest of the app
COPY my-app .

# Build Strapi admin (skip if already built)
RUN npm run build --if-present

# Expose Strapi port
EXPOSE 1337

# Start Strapi
CMD ["npm", "run", "start"]
