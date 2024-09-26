from flask import Flask
import redis

app = Flask(__name__)

# Connect to Redis
redis_client = redis.StrictRedis(host='redis', port=6379, db=0)

@app.route('/')
def home():
    # Default message
    return "Welcome to the Flask app! You can add jobs via the /add_job/<job> URL."

@app.route('/add_job/<job>')
def add_job(job):
    # Add a job to the Redis queue
    redis_client.lpush('jobs_queue', job)
    return f"Job {job} added to queue!"

if __name__ == "__main__":
    app.run(host='0.0.0.0')
