FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 


FROM nginx
# EXPOSE does not expose any port in dev env when
# we start a docker container locally.
# Its needed so that elastic beanstalk can expose
# port 80 from the docker container running on it.
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html 

