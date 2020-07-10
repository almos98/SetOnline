FROM nginx
COPY ./build/web_client/ /usr/share/nginx/html
RUN mv /usr/share/nginx/html/TripletOnline.html /usr/share/nginx/html/index.html
