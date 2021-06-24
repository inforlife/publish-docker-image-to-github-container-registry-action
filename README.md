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
    - name: Publish to GitHub Container Registry
      uses: inforlife/publish-docker-image-to-github-container-registry-action@2021.2
      with:
        container_pat: ${{ secrets.CR_PAT }}
        rubygems_pat: ${{ secrets.RR_PAT }}

```
## Secrets
**The following tokens must be created and added to the Repo's secrets via GitHub UI.**
- `CR_PAT` (Container Registry Private Access Token). The token should be unique for the repo and have `read:packages, repo, write:packages` scopes.
- `RR_PAT` (RubyGems Registry Private Access Token). The token should be unique for the repo and have `read:packages` scope. The token is needed only if the application has dependencies hosted at the [GitHub RubyGems registry](https://github.com/inforlife?tab=packages)

## Docker image
This action creates the package `ghcr.io/<ORGANIZATION>/<REPOSITORY>:<RELEASE_TAG>`.
