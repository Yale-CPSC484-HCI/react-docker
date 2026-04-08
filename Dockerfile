FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl ca-certificates git bash x11-apps && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 24.12.0 && \
    nvm alias default 24.12.0 && \
    npm install -g npm@11.7.0 && \
    npm install -g react@19.2.4 react-dom@19.2.4 vite@8.0.0

CMD ["/bin/bash"]
