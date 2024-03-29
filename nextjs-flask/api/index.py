from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route('/api/data', methods=['GET'])
def get_data():
    data = {"message": "Hello from Flask Backend!"}
    return jsonify(data)

if __name__ == "__main__":
    app.run(debug=True, port=8080)