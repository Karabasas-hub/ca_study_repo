# Bazinis image'as pitono workeriui
FROM python:3.9-slim

# Nustatom darbinę direktoriją
WORKDIR /worker

# Instaliuojam Redis client'ą
RUN pip install redis

# Kopijuojam workerio scriptą į konteinerį
COPY worker.py .

# Paleidžiam workerio scriptą
CMD ["python", "worker.py"]
