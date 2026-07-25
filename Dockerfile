FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN mkdir -p /etc/todos && chmod 777 /etc/todos
EXPOSE 3000
USER node
CMD ["node", "src/index.js"]
