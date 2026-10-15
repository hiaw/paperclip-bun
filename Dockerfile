FROM ghcr.io/paperclipai/paperclip:latest

# Switch to root to install system packages and global tools
USER root

# Install system dependencies (unzip is required by the Bun installer)
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 1. Install Bun globally into /usr/local/bin so the /paperclip volume mount doesn't hide it
ENV BUN_INSTALL="/usr/local"
RUN curl -fsSL https://bun.sh/install | bash

# 2. Install the Pi coding agent globally via npm
RUN npm install -g @earendil-works/pi-coding-agent

# Switch back to the node user for Paperclip runtime security
USER node
ENV HOME=/paperclip

# Ensure both global binaries and any persistent user binaries are in PATH
ENV PATH="/paperclip/.bun/bin:/paperclip/.local/bin:/usr/local/bin:${PATH}"
