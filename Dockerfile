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