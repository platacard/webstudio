# Use an official Node.js runtime as a parent image
FROM node:22.13.1-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the dependencies
COPY build/ ./build

# Build the application

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["node", ""]

