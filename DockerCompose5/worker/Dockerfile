FROM python:3.9

WORKDIR /app

RUN apt-get update && apt-get install -y libpq-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . . 

RUN pip install --no-cache-dir celery redis psycopg2-binary

CMD [ "celery", "-A", "myapp", "worker", "--loglevel=info" ]

