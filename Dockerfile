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

# Stage 2: Production (optionnel mais recommandé pour multi-stage)
FROM node:20-alpine

WORKDIR /app

# Copier uniquement les artifacts du build
COPY --from=build /app/dist ./dist
COPY --from=build /app/package*.json ./

# Installer uniquement les dépendances de production
RUN npm ci --only=production

EXPOSE 5173

CMD ["npm", "run", "preview"]