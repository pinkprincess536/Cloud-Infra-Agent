from flask import Flask, jsonify
import os
import psycopg

app = Flask(__name__)

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://example@example.invalid/example")

@app.get("/health")
def health():
    return jsonify(status="ok"), 200

@app.get("/v1/db-check")
def db_check():
    with psycopg.connect(DATABASE_URL, connect_timeout=2) as conn:
        conn.execute("SELECT 1")
    return jsonify(database="ok"), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
