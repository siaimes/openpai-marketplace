# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

FROM node:carbon

WORKDIR /usr/src/app

ARG VERSION
ARG PORT=9292

ENV NODE_ENV=production \
    SERVER_PORT=${PORT} \
    LOG_LEVEL=info \
    MARKETPLACE_API_URL=https://WorkerIP/openpaimarketplace_rest_server

RUN git clone https://github.com/microsoft/openpaimarketplace.git && \
    cd openpaimarketplace && \
    git checkout v1.2.0 && \
    cd webportal_plugin && \
    yarn install --production=false && \
    yarn build

EXPOSE ${SERVER_PORT}

WORKDIR /usr/src/app/openpaimarketplace/webportal_plugin

CMD ["yarn", "start"]
