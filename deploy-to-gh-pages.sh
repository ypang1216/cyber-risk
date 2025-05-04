#!/usr/bin/env bash

# Exit if any command fails
set -e

# Echo commands for debugging
set -x

# Clear any previous builds
echo "Cleaning previous build..."
rm -rf dist

# Make sure dependencies are installed
echo "Making sure dependencies are up-to-date..."
npm ci

# Force Tailwind to generate styles in development mode for maximum compatibility
export NODE_ENV=production
export TAILWIND_MODE=build

# Build the project with maximum compatibility
echo "Building the Astro site..."
npm run build

# Debug info - list all assets
echo "Checking generated files:"
find dist -type f | sort
echo "CSS files specifically:"
find dist -name "*.css" | sort

# Navigate into the build output directory
cd dist

# Create a local .nojekyll file to prevent GitHub Pages from trying to process with Jekyll
touch .nojekyll

# Initialize a new Git repository inside the dist folder
git init

# Set username and email for Git
git config user.name "GitHub Pages Deployment"
git config user.email "$(git config user.email)"

# Stage all files in the current directory
git add -A

# Commit the files
git commit -m "Deploy to GitHub Pages"

# Set the remote URL to your repository
git remote add origin git@github.com:ypang1216/cyber-risk.git

# Force push to the gh-pages branch (creates it if it doesn't exist)
git push -f origin master:gh-pages

# Navigate back to the project root
cd ..

echo "Deployed successfully to GitHub Pages!"
echo "Your site should be available at: https://ypang1216.github.io/cyber-risk/"