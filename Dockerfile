# Etapa 1: Build do projeto
# Usando uma imagem oficial do Node.js como a base para construir o projeto
FROM node:18-alpine AS builder

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar os arquivos do projeto para o diretório de trabalho
COPY package*.json ./

# Instalar as dependências do projeto
RUN npm install

# Copiar todos os arquivos do projeto para o diretório de trabalho
COPY . .

# Rodar o build da aplicação
RUN npm run build

# Etapa 2: Imagem de produção
# Usando uma imagem de servidor web Nginx como a base para servir o projeto
FROM nginx:alpine AS production

# Copiar o build da aplicação para o diretório de trabalho do Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expor a porta 80 para acessar a aplicação
EXPOSE 80

# Comando de inicialização do Nginx
CMD ["nginx", "-g", "daemon off;"]

#Criar a imagem:
#Executar o comando `docker build . -t <nome_user_dockerhub>/<nome_da_imagem>`
#docker build . -t gbetsa/lab-timer365

#Criar o container:
#Executar o comando `docker run -p 80:80 <nome_da_imagem>`
#docker run -p 80:80 gbetsa/lab-timer365

