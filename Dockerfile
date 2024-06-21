# Base stage
FROM node:18-alpine AS base

WORKDIR /src
COPY package*.json ./
EXPOSE 3000

# Production stage
FROM base AS production
ENV NODE_ENV=production
RUN npm ci
COPY . .
CMD ["node", "bin/www"]

# Development stage
FROM base AS dev
ENV NODE_ENV=development
RUN npm install -g nodemon && npm install
COPY . .
CMD ["nodemon", "bin/www"]
