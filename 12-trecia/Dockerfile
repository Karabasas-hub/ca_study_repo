# Naudojam pitono image'ą
FROM python:3.9-slim

# Nustatom darbinę direktoriją konteineryje
WORKDIR /usr/src/app

# Kopijuojam lokalų skriptą į konteinerį
COPY skriptas.py .

# Paleidžiam skriptą kai konteineris užsikuria
CMD ["python", "./skriptas.py" ]
