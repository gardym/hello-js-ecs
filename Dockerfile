FROM node:boron

# See https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md
# for why some of these things are here:

# Add Tini - wraps init because nodejs isn't mean to run as PID 1
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN mkdir -p /opt/hello-app
WORKDIR /opt/hello-app

COPY app/ /opt/hello-app
RUN npm install

EXPOSE 3000
CMD ["npm", "start"]

