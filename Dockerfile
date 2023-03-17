FROM node:16.3.0-alpine as build
WORKDIR /app

RUN npm install -g @angular/cli

COPY ./package.json .
RUN npm install
COPY . .
RUN ng build

FROM nginx as runtime
COPY --from=build /app/dist/myappdocker /usr/share/nginx/html
CMD ["npm", "server.js"]
