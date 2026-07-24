cat > Dockerfile << 'EOF'
# Estágio 1: BUILD
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Estágio 2: SERVE
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
EXPOSE 3000
USER node
CMD ["node", "src/index.js"]
EOF
cat > .dockerignore << 'EOF'
node_modules
.git
*.md
EOF
