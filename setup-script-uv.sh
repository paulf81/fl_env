#!/bin/bash
## Parameters
STUB="STUB_NAME_HERE"
FLORIS_BRANCH="develop"
FLASC_BRANCH="develop"
FLORIS_FLASC_FOLDER="modules"

# Get absolute path for project root
PROJECT_ROOT="$(pwd)/$STUB"

# Echo the stub name
echo "Setting up development environment for: $STUB"
echo "Using $FLORIS_FLASC_FOLDER as the FLORIS/FLASC folder"

# Create and enter project directory
mkdir -p "$STUB"
cd "$STUB" || exit

# Add the FLORIS/FLASC sub-folder
mkdir -p "$FLORIS_FLASC_FOLDER"
cd "$FLORIS_FLASC_FOLDER" || exit

# Clone repositories
echo "Cloning FLORIS..."
git clone https://github.com/NREL/floris
echo "Cloning FLASC..."
git clone https://github.com/NREL/flasc

# Set FLORIS and FLASC to track specified branches
echo "Setting FLORIS to $FLORIS_BRANCH branch..."
cd floris || exit
git fetch --all
git switch $FLORIS_BRANCH
git pull origin $FLORIS_BRANCH

cd ../flasc || exit
echo "Setting FLASC to $FLASC_BRANCH branch..."
git fetch --all
git switch $FLASC_BRANCH
git pull origin $FLASC_BRANCH

# Go back up to main project directory
cd ../.. || exit

# Create package directory structure
mkdir -p "${STUB}"
touch "${STUB}/__init__.py"

# Create .gitignore file
cat > .gitignore << EOL
# Virtual Environment
.venv/

# FLORIS and FLASC folder
${FLORIS_FLASC_FOLDER}/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# IDEs
.idea/
.vscode/
*.swp
*.swo

# Jupyter Notebook
.ipynb_checkpoints
EOL

# Initialize uv with explicit venv path
echo "Initializing uv..."
uv init

# Create pyproject.toml with local dependencies and explicit venv path
cat > pyproject.toml << EOL
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "$STUB"
version = "0.1.0"
description = "Development environment for FLORIS and FLASC"
requires-python = ">=3.11"
dependencies = [
    "jupyter~=1.1",
    "ruff~=0.7",
    "floris",
    "flasc"
]

[tool.hatch.build.targets.wheel]
packages = ["${STUB}"]

[tool.uv.sources]
floris = { path = "${FLORIS_FLASC_FOLDER}/floris", editable = true }
flasc = { path = "${FLORIS_FLASC_FOLDER}/flasc", editable = true }
EOL

# Set up the environment
echo "Setting up virtual environment and installing dependencies..."
uv venv
source .venv/bin/activate
uv pip install -e .

echo "Setup complete! Project structure created at $STUB"
echo "The virtual environment has been created and dependencies installed."
echo "To activate the environment in the future, run: source .venv/bin/activate"
echo "Opening VSCode..."
code .