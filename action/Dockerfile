FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    python3 \
    python3-pip \
    openssh-client \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' coder && \
    mkdir -p /home/coder/project && \
    chown -R coder:coder /home/coder

COPY action/start-agent.sh /usr/local/bin/start-agent.sh
RUN chmod +x /usr/local/bin/start-agent.sh

RUN npm install -g node-pty ws

COPY agent/agent.js /opt/codew-agent/agent.js

USER coder
WORKDIR /home/coder/project

ENV SHELL=/bin/bash
ENV TERM=xterm-256color

ENTRYPOINT ["/usr/local/bin/start-agent.sh"]
