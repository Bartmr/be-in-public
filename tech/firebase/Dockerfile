FROM node:16-buster

RUN apt-get update \
  && apt-get install -y nano

ENV DEBIAN_FRONTEND=noninteractive

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:$PATH"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    openjdk-11-jre

USER node

RUN npm install -g firebase-tools
