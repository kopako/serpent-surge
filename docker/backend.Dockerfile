FROM node as builder
WORKDIR /app
COPY ../game/serpent-surge-main/backend/package*.json ./
RUN npm install --production
COPY ../game/serpent-surge-main/backend/ .

FROM node:slim
WORKDIR /app
COPY --chown=node:node --from=builder /app /app
USER node
EXPOSE 3000

