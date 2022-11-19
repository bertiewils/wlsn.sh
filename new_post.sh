#!/usr/bin/env bash

set -e

# Make sure we're in the root dir
cd "$(git rev-parse --show-toplevel)"

POST_SLUG="$1"
if [ -z "$POST_SLUG" ]; then
  read -rp "Post Name (e.g. your-new-post): " POST_SLUG
fi
TIMESTAMP=$(date +%Y-%m-%d)
POST_FILENAME="${TIMESTAMP}-${POST_SLUG}.md"

hugo new "content/posts/${POST_FILENAME}"
