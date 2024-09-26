import time
import redis

# Connect to redis
redis_client = redis.StrictRedis(host="dockercompose3-redis-1", port=6379, db=0)

print("Worker started, listening for jobs")

while True:
  # Try to get a job from the queue
  job = redis_client.blpop('jobs_queue', timeout=5)
  if job:
    job_data = job[1].decode('utf-8')
    print(f"Processing job: {job_data}")
  else:
    print("No jobs in queue, worker is waiting...")
  time.sleep(1)
