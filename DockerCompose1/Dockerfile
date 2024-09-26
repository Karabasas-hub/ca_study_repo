# Naudojamas pitono image'as iš dockerhub
FROM python:3.9-slim

# Nustatoma darbinė direktoriją
WORKDIR /app

# Kopijuojami dabartinės direktorijos failai į konteinerį
COPY . /app

# Instaliuojam papildomus įrankius
RUN pip install --no-cache-dir flask redis

# Paviešinam portą
EXPOSE 5000

# Paleidžiam konteinerį
CMD [ "python", "app.py" ]
