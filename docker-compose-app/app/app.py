from flask import Flask
import redis
import os

app = Flask(__name__)

# Connect to Redis (the hostname 'redis' matches our docker-compose service name)
cache = redis.Redis(host='redis', port=6379)

@app.route('/')
def hello():
    # Increment the visit counter in Redis
    visits = cache.incr('hits')
    return f'Hello! This page has been visited {visits} times.\n'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)



