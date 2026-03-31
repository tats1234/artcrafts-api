from __future__ import annotations

import os

from flask import Flask, jsonify

app = Flask(__name__)

PRODUCTS = [
    {"id": 1, "name": "Handmade Clay Mug", "price_usd": 12.99},
    {"id": 2, "name": "Woven Basket", "price_usd": 18.50},
    {"id": 3, "name": "Beaded Bracelet", "price_usd": 7.00},
]


@app.get("/")
def hello_world():
    return jsonify({"message": "Hello World", "endpoints": ["/products"]})


@app.get("/products")
def list_products():
    return jsonify(PRODUCTS)


@app.get("/health")
def health():
    return jsonify({"status": "ok"})


if __name__ == "__main__":
    port = int(os.environ.get("PORT", "5000"))
    app.run(host="0.0.0.0", port=port)
