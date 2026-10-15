ARG PAPERCLIP_TAG=latest
FROM ghcr.io/paperclipai/paperclip:${PAPERCLIP_TAG}

# Install Bun globally so it is available to every user in the image.
ENV BUN_INSTALL=/usr/local

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL https://bun.sh/install | bash \
    && npm install --global --ignore-scripts @earendil-works/pi-coding-agent
