# Naudojam Node.js image kaip base image
FROM node:18

# Nustatom darbinę direktoriją konteineryje
WORKDIR /usr/src/app

# Kopijuojam package_hello.json ir package-lock.json
COPY package_hello.json package-lock.json* ./

# Installinam dependencies
#RUN npm install

# Nukopijuojam kas liko
COPY . .

# Paviešinam portą ant kurio veikia appsas
EXPOSE 3000

# Startinam Node.js
CMD [ "node", "helloApp.js" ]
