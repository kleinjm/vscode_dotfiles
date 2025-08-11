#!/bin/bash

# Git worktree helper function for Rails project.
# Use it like this:
# ./wt.sh <feature-name>
wt() {
  # Exit immediately on error
  set -e

  # Get the current Git project directory (must be inside a Git repo)
  local project_dir=$(git rev-parse --show-toplevel)

  # Get the base name of the current project folder
  local project_name=$(basename "$project_dir")

  # Get the desired feature/branch name from the first argument
  local feature_name="$1"

  # Fail fast if no feature name was provided
  if [ -z "$feature_name" ]; then
    echo "❌ Usage: wt <feature-name>"
    return 1
  fi

  # Define the parent folder where all worktrees go, beside the main repo
  local worktree_parent="$(dirname "$project_dir")/$project_name-worktrees"

  # Define the full path of the new worktree folder
  local worktree_path="${worktree_parent}/${feature_name}"

  # Create the parent worktrees folder if it doesn't exist
  mkdir -p "$worktree_parent"

  # Create the worktree and the branch
  git -C "$project_dir" worktree add -b "$feature_name" "$worktree_path"

  echo "📁 Setting up Rails project files..."

  # Copy essential environment files
  if [ -f "$project_dir/.env" ]; then
    cp "$project_dir/.env" "$worktree_path/.env"
    echo "  ✅ Copied .env into worktree."
  fi

  if [ -f "$project_dir/.env.example" ]; then
    cp "$project_dir/.env.example" "$worktree_path/.env.example"
    echo "  ✅ Copied .env.example into worktree."
  fi

  # Copy essential Rails config directories that might have local overrides
  if [ -d "$project_dir/.bundle" ]; then
    cp -R "$project_dir/.bundle" "$worktree_path/.bundle"
    echo "  ✅ Copied .bundle configuration into worktree."
  fi

  # Copy Agent OS and development tool configurations
  local dev_dirs=(.agent-os .claude .cursor .devcontainer .husky)
  for dir in "${dev_dirs[@]}"; do
    if [ -d "$project_dir/$dir" ]; then
      cp -R "$project_dir/$dir" "$worktree_path/$dir"
      echo "  ✅ Copied $dir into worktree."
    fi
  done

  # Copy essential config files
  local config_files=(.lintstagedrc.mjs .database_consistency.yml)
  for file in "${config_files[@]}"; do
    if [ -f "$project_dir/$file" ]; then
      cp "$project_dir/$file" "$worktree_path/$file"
      echo "  ✅ Copied $file into worktree."
    fi
  done

  # Create necessary directories that might be missing
  mkdir -p "$worktree_path/log"
  mkdir -p "$worktree_path/tmp"
  mkdir -p "$worktree_path/storage"
  mkdir -p "$worktree_path/public/assets"
  mkdir -p "$worktree_path/app/assets/builds"
  
  # Create .keep files for empty directories
  touch "$worktree_path/log/.keep"
  touch "$worktree_path/tmp/.keep"
  touch "$worktree_path/storage/.keep"
  touch "$worktree_path/app/assets/builds/.keep"

  echo "  ✅ Created necessary Rails directories."

  # Copy node_modules if it exists (for faster startup)
  if [ -d "$project_dir/node_modules" ]; then
    echo "  📦 Copying node_modules (this may take a moment)..."
    cp -R "$project_dir/node_modules" "$worktree_path/node_modules"
    echo "  ✅ Copied node_modules into worktree."
  else
    echo "  ⚠️  node_modules not found - you'll need to run 'yarn install' in the worktree."
  fi

  # Open the worktree in Cursor
  if command -v cursor &> /dev/null; then
    cursor "$worktree_path" &
    echo "  ✅ Opened worktree in Cursor."
  else
    echo "  ⚠️  Cursor not found - you can manually open: $worktree_path"
  fi

  # Provide helpful next steps
  echo ""
  echo "🎉 Worktree '$feature_name' created at $worktree_path"
  echo ""
  echo "Next steps:"
  echo "  cd $worktree_path"
  if [ ! -d "$project_dir/node_modules" ]; then
    echo "  yarn install"
  fi
  echo "  bundle install  # if needed"
  echo "  bin/dev         # to start development server"
  echo ""
  echo "Remember: This worktree shares Git history but has independent:"
  echo "  • Working directory (files, node_modules, etc.)"
  echo "  • Branch state"
  echo "  • Development server (can run on different ports)"
}

# If script is run directly, call the function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  wt "$1"
fi