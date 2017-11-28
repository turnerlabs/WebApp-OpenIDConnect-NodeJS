FROM node:8.7.0-alpine
WORKDIR /usr/src/app
COPY package.json .
RUN npm install --loglevel warn
COPY . .
CMD [ "npm", "start" ]
