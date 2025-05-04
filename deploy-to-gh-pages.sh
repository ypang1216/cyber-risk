#!/usr/bin/env bash

# Exit if any command fails
set -e

# Echo commands for debugging
set -x

# Build the project
echo "Building the Astro site..."
npm run build

# Navigate into the build output directory
cd dist

# Initialize a new Git repository inside the dist folder
git init

# Set username and email for Git (use your actual GitHub username and email)
git config user.name "GitHub Pages Deployment"
git config user.email "$(git config user.email)"

# Stage all files in the current directory
git add -A

# Commit the files
git commit -m "Deploy to GitHub Pages"

# Set the remote URL to your repository with a special token to authenticate
# This will push to the gh-pages branch
git remote add origin git@github.com:ypang1216/cyber-risk.git

# Force push to the gh-pages branch (creates it if it doesn't exist)
git push -f origin master:gh-pages

# Navigate back to the project root
cd ..

echo "Deployed successfully to GitHub Pages!"
echo "Your site should be available at: https://ypang1216.github.io/cyber-risk/"