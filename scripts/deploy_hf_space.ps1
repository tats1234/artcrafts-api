param(
  [Parameter(Mandatory = $false)]
  [string]$HfUsername,

  [Parameter(Mandatory = $false)]
  [string]$SpaceName,

  [Parameter(Mandatory = $false)]
  [string]$RemoteName = "hf"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -Path ".git")) {
  throw "Run this script from the repo root (where the .git folder exists)."
}

if (-not $HfUsername) {
  $HfUsername = Read-Host "Hugging Face username"
}

if (-not $SpaceName) {
  $SpaceName = Read-Host "Hugging Face Space name (e.g. artcrafts-api)"
}

$remoteUrl = "https://huggingface.co/spaces/$HfUsername/$SpaceName"

Write-Host "Using Space remote: $remoteUrl"

$existingRemotes = git remote
if ($existingRemotes -contains $RemoteName) {
  git remote set-url $RemoteName $remoteUrl
} else {
  git remote add $RemoteName $remoteUrl
}

Write-Host "Pushing main branch to Hugging Face Space..."
Write-Host "When prompted:"
Write-Host "- Username: $HfUsername"
Write-Host "- Password: your Hugging Face Access Token (not your account password)"

git push $RemoteName main

Write-Host "Done. Check the Space build logs on Hugging Face."
