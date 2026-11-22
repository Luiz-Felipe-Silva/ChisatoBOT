FROM node:22-bookworm-slim

# Instalar ferramentas necessárias para conversão de mídia
RUN apt-get update && apt-get install -y \
    ffmpeg \
    webp \
    libwebp-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./

# Instalar dependências do Node.js
RUN npm install --no-audit --no-fund

# Copiar o restante do projeto
COPY . .

# Compilar o projeto
RUN npm run build

# Porta do painel administrativo
EXPOSE 3333

# Iniciar o bot
CMD ["npm", "start"]
