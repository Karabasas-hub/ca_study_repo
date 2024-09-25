# syntax=docker/dockerfile:1.2

# Use the official Node.js image
FROM node:14

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json ./
COPY package-lock.json ./

# Use BuildKit to pass secret file
RUN --mount=type=secret,id=mysecret \
    npm install --silent && \
    cp /run/secrets/mysecret /usr/src/app/secret.txt

# Copy the application files, including the secret file
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Run the application
CMD ["npm", "start"]
