FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY . .

EXPOSE 4321

CMD ["npx", "serve", "-l", "4321", "."]
