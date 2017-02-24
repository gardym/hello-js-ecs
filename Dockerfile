FROM node:boron

RUN mkdir -p /opt/hello-app
WORKDIR /opt/hello-app

COPY app/ /opt/hello-app
RUN npm install

EXPOSE 3000
CMD ["npm", "start"]

