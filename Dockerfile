FROM fedora:38

# Install Node.js and Yarn
RUN dnf -y update && \
    dnf -y install curl git nodejs npm && \
    npm install -g yarn && \
    dnf clean all

# Create a non-root user
RUN useradd -m -s /bin/bash node
USER node

# Clone the repository
RUN git clone https://github.com/Itzpatron/PATRON-MD.git /home/node/blue

# Set the working directory
WORKDIR /home/node/blue

# Set permissions and install dependencies
RUN chmod -R 777 /home/node/blue && \
    yarn install && \
    yarn add http

# Copy server.js and start.sh scripts
COPY server.js .
COPY start.sh .

# Start the application
CMD ["bash", "start.sh"]
