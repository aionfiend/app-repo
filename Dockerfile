FROM ghcr.io/requarks/wiki:2.5
USER root
RUN mkdir -p /wiki/data && chown -R node:node /wiki/data
COPY --chown=node:node config.yml /wiki/config.yml
USER node
