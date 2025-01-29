# Use Node.js to build the app
FROM node:18 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Use Nginx to serve the built Angular app
FROM nginx:alpine
COPY --from=build /app/dist/angular-gcp-deploy /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
