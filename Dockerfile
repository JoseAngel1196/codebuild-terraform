# Use a minimal base image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Run a command to print "Hello, World!" when the container starts
CMD echo "Hello, World!"