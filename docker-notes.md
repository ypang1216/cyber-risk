# Docker Documentation for Cyber Risk Platform

This document explains how Docker is implemented in the Cyber Risk Segmentation Platform project.

## Dockerfile

The `Dockerfile` in our project is a multi-stage build file that containerizes our Astro application:

```dockerfile
FROM node:18-alpine AS base

# Set working directory
WORKDIR /app

# Install dependencies
FROM base AS deps
COPY package.json package-lock.json ./
RUN npm ci

# Build the application
FROM deps AS build
COPY . .
RUN npm run build

# Production image, copy all the files and run the app
FROM base AS runner

ENV NODE_ENV production

# Copy built application
COPY --from=build /app/dist /app/dist
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/package.json /app/package.json

EXPOSE 4321

# Start the application
CMD ["npm", "run", "preview", "--", "--host", "0.0.0.0"]
```

### Dockerfile Breakdown

1. **Base Stage**
   - Uses `node:18-alpine` as the lightweight base image
   - Sets `/app` as the working directory

2. **Dependencies Stage**
   - Inherits from the base stage
   - Copies only package.json files to leverage Docker caching
   - Installs dependencies using `npm ci` for deterministic builds

3. **Build Stage**
   - Inherits from dependencies stage
   - Copies all project files
   - Builds the Astro application with `npm run build`

4. **Runner Stage**
   - Creates a minimal production image
   - Sets NODE_ENV to production
   - Copies only the necessary files (dist directory, node_modules, package.json)
   - Exposes port 4321 for the application
   - Starts the application using the preview server with host set to 0.0.0.0 to allow external connections

## Docker Compose Configurations

### Production (docker-compose.yml)

The `docker-compose.yml` file orchestrates the deployment of the containerized application in a production environment:

```yaml
version: '3'

services:
  cyber-risk-app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "4321:4321"
    restart: unless-stopped
    environment:
      - NODE_ENV=production
    # Add healthcheck to ensure service is running properly
    healthcheck:
      test: ["CMD", "wget", "--spider", "-q", "http://localhost:4321"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

### Development (docker-compose.dev.yml)

The development configuration is designed for iterative development with hot reloading:

```yaml
version: '3'

services:
  cyber-risk-app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "4321:4321"
    restart: unless-stopped
    environment:
      - NODE_ENV=development
    volumes:
      # Mount source code for hot reloading
      - ./src:/app/src
      - ./public:/app/public
    command: npm run dev -- --host 0.0.0.0
    healthcheck:
      test: ["CMD", "wget", "--spider", "-q", "http://localhost:4321"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 20s
```

### Development Dockerfile (Dockerfile.dev)

A simpler Dockerfile for development that prioritizes faster builds and hot reloading:

```dockerfile
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Expose port
EXPOSE 4321

# Start development server with hot reloading
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
```

## Production vs Development Mode

### Why NODE_ENV=production in Production

1. **Performance**: Optimizes JavaScript execution, enables caching
2. **Security**: Hides detailed error messages and stack traces
3. **Size**: Enables minification and compression of assets
4. **Stability**: Disables development-only features and warnings

### Why NODE_ENV=development for Local Work

1. **Hot Reloading**: Code changes reflect immediately without restart
2. **Detailed Errors**: Provides verbose error messages for debugging
3. **Source Maps**: Makes debugging easier by mapping to original code
4. **Developer Tools**: Enables development-specific features and tooling

## Common Docker Commands

### Building and Running

```bash
# Build and start production containers
docker-compose up -d

# Build and start development containers
docker-compose -f docker-compose.dev.yml up -d

# View container logs
docker-compose logs
docker-compose -f docker-compose.dev.yml logs

# Stop all containers
docker-compose down
docker-compose -f docker-compose.dev.yml down

# Rebuild containers (after code changes)
docker-compose build
docker-compose up -d
```

### Maintenance

```bash
# View running containers
docker ps

# Access container shell
docker exec -it <container_id> sh

# View container resource usage
docker stats
```

## Benefits of Docker in This Project

1. **Consistency**: Ensures the application runs the same way in all environments
2. **Isolation**: Keeps dependencies and runtime encapsulated
3. **Portability**: Makes deployment easy across different systems
4. **Scalability**: Simplifies running multiple instances of the application
5. **Version Control**: Allows tracking of environment configurations alongside code

_Last updated: May 3, 2025_