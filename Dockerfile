FROM ubuntu:24.04

# basic dependencies
RUN apt-get update && \
    apt-get install -y curl ca-certificates git bash x11-apps less && \
    rm -rf /var/lib/apt/lists/*

# Avoid interaction during build
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    ca-certificates \
    && add-apt-repository ppa:xtradeb/apps -y \
    && apt-get update \
    && apt-get install -y chromium \
    && rm -rf /var/lib/apt/lists/*

# Chromium on ARM64/Docker often needs these environment variables
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROME_PATH=/usr/lib/chromium/

# web development tools
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 24.12.0 && \
    nvm alias default 24.12.0 && \
    npm install -g npm@11.7.0 && \
    npm install -g react@19.2.4 react-dom@19.2.4 vite@8.0.0

CMD ["/bin/bash"]
