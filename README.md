# Publish Docker Image to GitHub Container Registry
A GitHub Action which builds a Docker Image, from the latest release (git tag), and publishes it to GitHub Container Registry. 
## Usage
Add the following to `.github/workflows/publish-image.yml`

```yaml
name: Publish Docker Image
on:
  release:
    types: [published]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Publish to GitHub Packages
      uses: inforlife/publish-docker-image-to-github-container-registry-action
@2021.1
      with:
        owner: ${{github.repository_owner}}
        pat: ${{ secrets.CR_PAT }}
```
## Secrets
- **The `CR_PAT` (Container Registry Private Access Token) must be created and added to the Repo's secrets via GitHub UI.** The token should be unique for the repo and have `read:packages, repo, write:packages` permissions.
## Docker image
This action creates the package `ghcr.io/<ORGANIZATION>/<REPOSITORY>:<RELEASE_TAG>`.

