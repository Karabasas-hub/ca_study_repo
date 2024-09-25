# Naudojam Node.js image'ą kaip pagrindą
FROM node:18

# Sukuriam non-root userį ir grupę
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Nustatom darbinę direktoriją
WORKDIR /usr/src/app

# Kopijuojam package.json ir package-lock.json
COPY package*.json ./

# Kopijoujam likusią aplikaciją
COPY . . 

# Pakeičiam ownershipą app direktorijos į non-root userį
RUN chown -R appuser:appuser /usr/src/app

# Pasikeičiam į non-root userį
USER appuser

# Paviešinam portą
EXPOSE 3000

# Užvedam Node.js
CMD [ "node", "serviceApp.js" ]

