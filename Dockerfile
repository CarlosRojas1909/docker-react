FROM node:alpine as builder 

WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .
RUN ["npm","run", "build"]
# until this point dockerfile will create a folder called build, we are copying this file into a production server (not a development server) since we don't need to make changes in our code anymore
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html 