FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    webp \
    libwebp-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar dependências e esquema Prisma
COPY package*.json ./
COPY prisma ./prisma

# Instalar dependências
RUN npm install --no-audit --no-fund

# Copiar o código
COPY . .

# Compilar aplicação
RUN npm run build

# Preparar banco de dados e iniciar o bot
CMD ["sh", "-c", "npx prisma db push && npm start"]
