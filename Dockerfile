FROM node:14-alpine

# First install dependencies
COPY ./package.json ./app/
WORKDIR /app/
ENV NODE_ENV production
RUN apk add --no-cache -q git openssl ca-certificates python-dev g++ make
RUN npm install --no-progress --production && npm install --no-progress passport-ldapjs passport-ldapauth
# Later, copy the app files. That improves development speed as buiding the Docker image will not have 
# to download and install all the NPM dependencies every time there's a change in the source code
COPY . /app
EXPOSE 3000
ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]
CMD ["node", "index.js"]
