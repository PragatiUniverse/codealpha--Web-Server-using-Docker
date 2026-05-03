from flask import Flask, jsonify
import os
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({
        'message': 'Hello World from Docker!',
        'timestamp': datetime.utcnow().isoformat(),
        'container': os.environ.get('HOSTNAME', 'unknown')
    })

@app.route('/health')
def health():
    return jsonify({'status': 'healthy'})

@app.route('/api/info')
def info():
    return jsonify({
        'app': 'Flask Web Server',
        'version': '1.0.0',
        'environment': os.environ.get('FLASK_ENV', 'development'),
        'uptime': 'N/A'  # Simple version
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)