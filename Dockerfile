# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
FROM node:latest

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./


# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY . ./
COPY azLambda .
COPY main .
COPY entrypoint.sh .
RUN chmod 777 entrypoint.sh && chmod 777 main && chmod 777 azLambda
# Run the web service on container startup.
ENTRYPOINT [ "./entrypoint.sh" ]
