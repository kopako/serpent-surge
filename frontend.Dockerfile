FROM nginx:latest
COPY ./game/serpent-surge-main/frontend /usr/share/nginx/html/
COPY ./game/serpent-surge-main/nginx/game.conf /etc/nginx/conf.d/default.conf
