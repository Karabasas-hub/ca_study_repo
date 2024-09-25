# Naudojam pitoną kaip base image'ą
ARG PYTHON_VERSION=3.9-slim
FROM python:${PYTHON_VERSION}

# Nusistatom darbinę direktoriją
WORKDIR /usr/src/app

# Kopijuojam skriptą į konteinerį
COPY skriptas.py .

# Panaudojam dar ENTRYPOINT 
ENTRYPOINT [ "python", "./skriptas.py" ]

