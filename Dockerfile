# Stage 1: Build
FROM node:20-alpine AS build

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le code source
COPY . .

# Déclarer l'argument de build et l'exposer comme variable d'environnement
ARG BUILD_ID=local
ENV VITE_BUILD_ID=$BUILD_ID

# Générer le build optimisé
RUN npm run build

# Stage 2: Production avec Nginx
FROM nginx:alpine

# Copier uniquement les artifacts du build dans Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Nginx démarre par défaut
CMD ["nginx", "-g", "daemon off;"]