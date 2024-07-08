FROM nginx:stable

COPY ./index.html /var/www/index.html
COPY ./nginx.conf /etc/nginx/nginx.conf 
ENTRYPOINT ["nginx", "-g", "daemon off;"]