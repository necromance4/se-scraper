FROM node:10.16.0-alpine

ENV app_dir=/home/node/app
ENV CHROME_BIN="/usr/bin/chromium-browser"
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
      chromium@edge=~73.0.3683.103 \
      nss@edge \
      freetype@edge \
      harfbuzz@edge \
      ttf-freefont@edge

RUN yarn add puppeteer@1.12.2

RUN apk add --update \
    npm

RUN mkdir -p /home/node/Downloads \
    && mkdir -p $app_dir

RUN npm install nodemon -g

RUN npm install express

USER node

COPY --chown=node:node . $app_dir

WORKDIR $app_dir

RUN npm install

WORKDIR $app_dir/src/puppeteer-cluster/

RUN npm install \
    && npm run build

WORKDIR $app_dir

CMD [ "nodemon", "server/server.js" ]

