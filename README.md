# ArtCrafts API (Flask)

Small “Hello World” REST API packaged as a Docker container.

## Endpoint

- `GET /products` → static JSON list of dummy craft products

Example:

```bash
curl http://localhost:5000/products
```

## Build & run locally (Docker)

```bash
docker build -t artcrafts-api:latest .
docker run --rm -p 5000:5000 artcrafts-api:latest
```

## Run with Docker Compose

### Option A: build locally with Compose

```bash
docker compose up -d --build
```

Test:

```bash
curl http://localhost:5000/products
```

### Option B: run a registry image with Compose

```bash
cp .env.example .env
# edit .env and set IMAGE_URI=...
docker compose pull
docker compose up -d --no-build
```

Test:

```bash
curl http://localhost:5000/products
```

## Container registry (recommended free option: GitHub Container Registry / GHCR)

GHCR image name format:

- `ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0`

### Push image to GHCR

1) Create a GitHub Personal Access Token (classic) with `write:packages` (and `read:packages`).

2) Login, build, tag, push:

```bash
echo <YOUR_GITHUB_TOKEN> | docker login ghcr.io -u <github_username> --password-stdin
docker build -t artcrafts-api:1.0.0 .
docker tag artcrafts-api:1.0.0 ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
docker push ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
```

PowerShell equivalent login:

```powershell
$env:GITHUB_TOKEN = "<YOUR_GITHUB_TOKEN>"
$env:GITHUB_TOKEN | docker login ghcr.io -u "<github_username>" --password-stdin
```

### Pull from GHCR and run locally

```bash
docker pull ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
docker run --rm -p 5000:5000 ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
```

Or using Compose:

```bash
cp .env.example .env
# edit .env and set:
# IMAGE_URI=ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0
docker compose pull
docker compose up -d --no-build
```
