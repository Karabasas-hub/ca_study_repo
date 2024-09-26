from flask import Flask
import redis

app = Flask(__name__)
redis_client = redis.StrictRedis(host='redis', port=6379, decode_responses=True)

@app.route('/')
def index():
    redis_client.incr('visits')
    visits = redis_client.get('visits')
    return f'Hello! This page has been visited {visits} times.'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
