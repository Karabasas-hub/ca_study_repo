# Naudosime Ubuntu image'ą
FROM ubuntu:20.04

# Atsinaujinam paketus susinestaliuojam pitoną
RUN apt-get update && apt-get install -y python3

# Kopijuojam pitono scriptą į konteinerį
COPY hello-docker.py /usr/src/app/hello-docker.py

# Nustatom darbinę direktoriją
WORKDIR /usr/src/app

# Paleidžiam pitono scriptą
CMD [ "python3", "hello-docker.py" ]

