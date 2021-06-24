#!/bin/bash
set -e

if [ -z "${INPUT_CONTAINER_PAT}" ]; then
  echo "PAT not found. Add a Personal Access Token with `read:packages` & `read:packages` permissions to the repository's secrets and then `pat: ${{ secrets.CR_PAT }}` to the workflow file."
  exit 1
fi

RELEASE_TAG=${GITHUB_REF:10}

# login with new container registry url and PAT
echo ${INPUT_CONTAINER_PAT} | docker login ghcr.io -u ${GITHUB_REPOSITORY_OWNER} --password-stdin
# new container registry urls added
docker build --build-arg RELEASE_TAG=${RELEASE_TAG} --build-arg RR_PAT=${INPUT_RUBYGEMS_PAT} --tag ghcr.io/inforlife/${GITHUB_REPOSITORY}:${RELEASE_TAG} --cache-from ghcr.io/inforlife/${REPO}:latest .
docker push ghcr.io/inforlife/${GITHUB_REPOSITORY}:${RELEASE_TAG}

docker logout
