# Use official Node image to build the app
FROM node:18 AS builder

WORKDIR /app
COPY frontend/ ./frontend
WORKDIR /app/frontend

RUN npm ci
RUN npm run build

# Use nginx to serve the built frontend
FROM nginx:alpine
COPY --from=builder /app/frontend/dist /usr/share/nginx/html
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"] 