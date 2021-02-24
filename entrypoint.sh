#!/bin/bash
set -e

if [ -z "${INPUT_PAT}" ]; then
  echo "PAT not found. Add a Personal Access Token with `read:packages` & `read:packages` permissions to te repository's secrets and then `pat: ${{ secrets.CR_PAT }}` to the workflow file."
  exit 1
fi

RELEASE_TAG=${GITHUB_REF:10}

# login with new container registry url and PAT
echo ${INPUT_PAT} | docker login ghcr.io -u ${INPUT_OWNER} --password-stdin
# new container registry urls added
docker build --build-arg RELEASE_TAG=${RELEASE_TAG} --tag ghcr.io/${GITHUB_REPOSITORY}:${RELEASE_TAG} --cache-from ghcr.io/${INPUT_ORGANIZATION}/${REPO}:latest .
docker push ghcr.io/${GITHUB_REPOSITORY}:${RELEASE_TAG}

docker logout