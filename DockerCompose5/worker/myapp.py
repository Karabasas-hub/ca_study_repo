from celery import Celery

# Create a Celery instance
app = Celery('myapp', broker='redis://cache:6379/0')

@app.task
def add(x, y):
    return x + y

@app.task
def multiply(x, y):
    return x * y
