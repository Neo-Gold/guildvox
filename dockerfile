# Start from a base image (e.g., Node.js, Python, Alpine Linux, etc.)
FROM node:22-alpine

# Set the working directory inside the container
WORKDIR /my-app

# Copy application files from the host to the container
COPY . .

# Run commands to install dependencies or set up the environment
RUN yarn install --production

# Define the command to run when the container starts
CMD ["node", "./src/index.js"]
