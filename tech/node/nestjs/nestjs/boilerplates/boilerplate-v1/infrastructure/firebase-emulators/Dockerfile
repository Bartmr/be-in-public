FROM node:16-buster

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    openjdk-11-jre

ENV PATH="${PATH}:/home/node/.npm-global/bin"

COPY start-firebase-emulators.sh \
  .firebaserc \
  firebase.json \
  /home/node/

USER node

WORKDIR /home/node

RUN npm install -g firebase-tools

ENTRYPOINT ["./start-firebase-emulators.sh"]
