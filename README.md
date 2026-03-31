---
title: ArtCrafts API (Flask)
sdk: docker
app_port: 5000
---

# ArtCrafts API (Flask)

Small "Hello World" REST API packaged as a Docker container.

## Endpoint

- `GET /products` -> static JSON list of dummy craft products

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

## Deploy to Hugging Face Spaces (Docker)

This repo is compatible with a Hugging Face Docker Space (see the YAML block at the top of this file with `sdk: docker` and `app_port: 5000`).

High-level steps:

1) Create a new Space with **SDK = Docker** and make it public.
2) Push/upload these files to the Space repo: `Dockerfile`, `app.py`, `requirements.txt`, `README.md`.
3) After the Space builds, your API will be reachable at:
   - `https://<space-subdomain>.hf.space/products`

Test:

```bash
curl http://localhost:5000/products
```

## Container registry (recommended free option: GitHub Container Registry / GHCR)

GHCR image name format:

- `ghcr.io/<github_username_or_org>/artcrafts-api:1.0.0`

### Option A: push from your PC (manual)

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

### Option B: publish via GitHub Actions (no Docker PAT needed)

This repo includes a workflow at `.github/workflows/publish-ghcr.yml` that builds and publishes the image to GHCR:

- Push to `main` -> publishes `latest` (and a short SHA tag).
- Push tag `v1.0.0` -> publishes `1.0.0`.

Tag and push a release:

```bash
git tag v1.0.0
git push origin v1.0.0
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
