# Assignment Report — Flask REST API in Docker + GHCR

## (a) Hello World API endpoint (Flask)

**Goal:** Build a small REST API in Flask and run it as a Docker container.

**Implemented endpoints:**

- `GET /` → returns “Hello World” message
- `GET /products` → returns static JSON list of dummy craft products (2–3 items)
- `GET /health` → simple health check

**Source files:**

- `app.py` (Flask app)
- `requirements.txt` (dependencies)

**Sample output (`GET /products`):**

```json
[
  {"id": 1, "name": "Handmade Clay Mug", "price_usd": 12.99},
  {"id": 2, "name": "Woven Basket", "price_usd": 18.50},
  {"id": 3, "name": "Beaded Bracelet", "price_usd": 7.00}
]
```

## (b) Docker container build

**Dockerfile:** `Dockerfile` (packages the Flask API into an image).

**Build locally:**

```bash
docker build -t artcrafts-api:1.0.0 .
```

**Run locally:**

```bash
docker run --rm -p 5000:5000 artcrafts-api:1.0.0
```

**Test locally:**

```bash
curl http://localhost:5000/products
```

## (c) Deployment & sharing

### (i) Push image to registry (GitHub Container Registry — GHCR)

**Chosen registry:** GitHub Container Registry (`ghcr.io`) — free for public images.

**Image name format:**

- `ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0`

**Option A: manual push (from your PC)**

1) Create a GitHub Personal Access Token (classic) with at least:
   - `write:packages`
   - `read:packages`
   - (If your repo is private, also enable `repo`.)

2) Login, build, tag, and push:

```bash
echo <YOUR_GITHUB_TOKEN> | docker login ghcr.io -u <github_username> --password-stdin
docker build -t artcrafts-api:1.0.0 .
docker tag artcrafts-api:1.0.0 ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
docker push ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
```

**Note:** To allow your lecturer/marker to pull without logging in, set the package visibility to **Public** in GitHub Packages.

**Option B: publish via GitHub Actions (recommended)**

This repository includes `.github/workflows/publish-ghcr.yml`. After pushing your code to GitHub:

- pushing to `main` publishes `latest`
- pushing a tag like `v1.0.0` publishes `1.0.0`

```bash
git tag v1.0.0
git push origin v1.0.0
```

### (ii) Docker Compose file

**Compose file:** `docker-compose.yml`

Run locally with Compose (build from source):

```bash
docker compose up -d --build
```

### (iii) How to pull from registry and run locally

Pull the image from GHCR:

```bash
docker pull ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
```

Run the pulled image:

```bash
docker run --rm -p 5000:5000 ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
```

Or run using Compose (no build, uses registry image):

```bash
cp .env.example .env
# edit .env and set:
# IMAGE_URI=ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
docker compose pull
docker compose up -d --no-build
```

**Test:**

```bash
curl http://localhost:5000/products
```

## Evidence to include (screenshots / outputs)

- `docker build` success output
- `docker images` showing `artcrafts-api:1.0.0`
- `docker compose ps` showing container is `Up` on port `5000`
- `curl http://localhost:5000/products` output
- GHCR package page showing the pushed tag `1.0.0` (and visibility)
