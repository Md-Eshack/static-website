from flask import Flask, jsonify
from flask_cors import CORS
from datetime import datetime

app = Flask(__name__)

# ✅ Enable CORS for all routes
CORS(app)

@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "message": "Python API running on EC2",
        "timestamp": datetime.utcnow().isoformat() + "Z"
    })

@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat() + "Z"
    })

@app.route("/data", methods=["GET"])
def data():
    return jsonify({
        "service": "Cloud Python API",
        "stack": ["AWS", "Terraform", "Flask"],
        "timestamp": datetime.utcnow().isoformat() + "Z"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)