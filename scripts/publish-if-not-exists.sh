#!/usr/bin/env bash
set -euo pipefail

VERSION=$(jq -r '.version' package.json)
NAME=$(jq -r '.name' package.json)
TAG="v${VERSION}"

echo "Checking if ${NAME}@${VERSION} is already published..."

if npm view "${NAME}@${VERSION}" >/dev/null 2>&1; then
  echo "Skipping publish: ${NAME}@${VERSION} already exists"
  exit 0
fi

echo "Version not published. Proceeding..."

# Configure git
git config user.email "ci@dydx.exchange"
git config user.name "github_actions"

# Create tag only if it doesn't already exist
if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "Git tag ${TAG} already exists"
else
  git tag "$TAG"
  git push origin "$TAG"
fi

echo "Publishing to npm..."
npm publish --provenance
