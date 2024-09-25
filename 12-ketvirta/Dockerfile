# Naudojam pitono image'ą
FROM python:3.9-slim

# Nustatom darbinę direktoriją
WORKDIR /usr/src/app

# Kopijuojame skriptą į konteinerį
COPY skriptas.py .

# Naudojam ENTRYPOINT vieotje CMD
ENTRYPOINT [ "python", "./skriptas.py" ]
