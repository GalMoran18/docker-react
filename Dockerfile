FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

RUN npm run build


FROM nginx
#include the port so it can be deployed on AWS. also used for readibility
EXPOSE 80
COPY  --from=builder home/node/app/build /usr/share/nginx/html
#nginx will start as it is the default command.

