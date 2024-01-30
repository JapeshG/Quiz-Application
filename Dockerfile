# # Use an official Node.js runtime as a base image
# FROM node:14-alpine

# # Set the working directory inside the container
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the application code to the working directory
# COPY . .

# # Build the React application
# RUN npm run build
# EXPOSE 3000
# CMD ["npm", "start"]
# Build stage
# Build stage
FROM node:14 as builder
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build

# Serve stage
FROM nginx:alpine as production-stage
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]