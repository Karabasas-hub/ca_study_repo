# Vėl naudojam pitono image'ą
FROM python:3.9-slim

# Nusistatom darbinę direktoriją
WORKDIR /app

# Kopijuojam dabartinę direktoriją ir jos turinį į konteinerį
COPY . /app

# Instaliuojam trūkstamas dalis
RUN pip install --no-cache-dir flask redis

# paviešinam portą
EXPOSE 5000

# Paleidžiam appsą
CMD [ "python", "app.py" ]

