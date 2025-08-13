FROM node
 
WORKDIR /app
 
COPY game/serpent-surge-main/backend/package.json package.json
# COPY package-lock.json package-lock.json
 
RUN npm install
 
COPY ./game/serpent-surge-main/backend/ .

EXPOSE 3000
