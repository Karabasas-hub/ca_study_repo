# Pirma stadija - C programa
FROM gcc:latest AS builder

# Nustatom darbinę direktoriją
WORKDIR /usr/src/app

# Kopijuojam C programos source kodą į konteinerį
COPY labas.c .

# Kompiliuojam C programą
RUN gcc -o labutis labas.c

# Antra stadija - Paleidžiam sukompiliuotą programą
FROM debian:latest

# Nustatom darbinę direktoriją
WORKDIR /usr/src/app

# Kopijuojam sukompiliuotą binary iš pirmos stadijos
COPY --from=builder /usr/src/app/labutis .

# Paleidžiam sukompiliuotą programą
CMD ["./labutis"]
