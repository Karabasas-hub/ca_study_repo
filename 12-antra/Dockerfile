# Naudosime Ubuntu image'ą
FROM ubuntu:20.04

# Panaudojam aplinkos kintamąjį, kad pasisveikinti
ENV GREETING="Hello from Docker with ENV (almost EV hehe)"

# Atsinaujinam paketus susinestaliuojam pitoną
RUN apt-get update && apt-get install -y python3

# Kopijuojam pitono scriptą į konteinerį
COPY helo-doker.py /usr/src/app/helo-doker.py

# Nustatom darbinę direktoriją
WORKDIR /usr/src/app

# Paleidžiam pitono scriptą
CMD [ "python3", "helo-doker.py" ]

