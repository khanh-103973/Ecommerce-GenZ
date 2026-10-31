# Build from the repository root: docker build -f GenZFashion.Web/Dockerfile .
FROM node:24-bookworm-slim AS build
WORKDIR /src

COPY GenZFashion.Web/package.json GenZFashion.Web/package-lock.json ./
RUN npm ci

COPY GenZFashion.Web/index.html GenZFashion.Web/vite.config.js ./
COPY GenZFashion.Web/src/ ./src/
COPY GenZFashion.Web/public/ ./public/
RUN npm run build

FROM nginx:stable-alpine AS runtime
COPY GenZFashion.Web/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/dist/ /usr/share/nginx/html/
EXPOSE 8080
