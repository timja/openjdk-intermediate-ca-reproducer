FROM nginx:1.27

COPY docker/localhost.conf /etc/nginx/conf.d/localhost.conf
COPY ca/enduser.crt ca/enduser.key /etc/nginx/
COPY content/index.html /etc/nginx/html/index.html
