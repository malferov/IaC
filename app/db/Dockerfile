FROM node:8
ARG port
EXPOSE $port
COPY db.js .
ENTRYPOINT ["node", "db.js"]
