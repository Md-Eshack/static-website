#!/bin/bash
yum update -y
yum install -y python3 git

pip3 install flask flask-cors

mkdir -p /opt/python-api
sudo tee /opt/python-api/app.py > /dev/null <<'EOF'
from flask import Flask, jsonify, make_response
from datetime import datetime

app = Flask(__name__)

def cors(payload):
    response = make_response(jsonify(payload))
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    return response

@app.route("/health", methods=["GET", "OPTIONS"])
def health():
    return cors({
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat() + "Z"
    })

@app.route("/data", methods=["GET", "OPTIONS"])
def data():
    return cors({
        "service": "Cloud Python API",
        "stack": ["AWS", "Terraform", "Flask"]
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF


nohup python3 /opt/python-api/app.py &
