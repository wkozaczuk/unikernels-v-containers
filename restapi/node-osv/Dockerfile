FROM node:8-alpine

WORKDIR /app

ADD ./rest.js /app/rest.js
ADD ./node_modules /app/node_modules

EXPOSE 8080

CMD ["node","/app/rest.js"]
