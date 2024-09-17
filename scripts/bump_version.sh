#!/bin/sh

# Parse the boolean parameter
SHOW_IMPORTANT_TEXT=true
if [ "$1" = "--no-warning" ]; then
  SHOW_IMPORTANT_TEXT=false
fi

# Search for the first line that starts with "version" in package.json
# Get the value in the quotes
VERSION=$(cat package.json | jq -r '.version')

echo "Current version is $VERSION. Enter new version (or press enter to skip):"
read NEW_VERSION

# If NEW_VERSION is not empty, replace the version in package.json
if [ -n "$NEW_VERSION" ]; then
  sed -i '' "s/  \"version\": \"$VERSION\"/  \"version\": \"$NEW_VERSION\"/" package.json
  echo "Version bumped to $NEW_VERSION"
  npm i
fi

# ANSI color code for red
RED='\033[0;31m'
# ANSI color code for resetting color
NC='\033[0m'

# Display the important text only if SHOW_IMPORTANT_TEXT is true
if [ "$SHOW_IMPORTANT_TEXT" = true ]; then
  echo ""
  echo "${RED}**************************************************************"
  echo "* IMPORTANT: If you are creating a PR, run \`npm run prepare_for_pr\` *"
  echo "**************************************************************${NC}"
  echo ""
fi
