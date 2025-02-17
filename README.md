# fl_env

Automatic creation of a FLORIS/FLASC env via shell script

## Introduction

A common task in my work flow is to create a custom directory with FLORIS/FLASC locally pip installed and a new repo initialized, whenever embarking on a new project analysis.

The purpose of this repo is to share some scripts I'm working to automate this process.

## Usage

The scripts should all be runnable (unix/linux/mac) from the command line.  Note some parameters appear at the top of the script.  For now I have uv version but could later and conda or mamba etc.

## setup-script-uv.sh

The `setup-script-uv.sh` script automates the setup of a development environment for FLORIS and FLASC. Here is what the script does step-by-step:

1. **Parameters Setup**: Defines parameters for the project stub name, FLORIS and FLASC branches, and the folder to contain FLORIS and FLASC.
2. **Project Directory Creation**: Creates a project directory and navigates into it.
3. **FLORIS/FLASC Folder Setup**: Creates a sub-folder for FLORIS and FLASC and navigates into it.
4. **Repository Cloning**: Clones the FLORIS and FLASC repositories from GitHub.
5. **Branch Setup**: Checks out the specified branches for both FLORIS and FLASC.
6. **Package Directory Structure**: Creates the package directory structure and initializes it with an `__init__.py` file.
7. **.gitignore Creation**: Creates a `.gitignore` file with common patterns to ignore.
8. **UV Initialization**: Initializes the UV environment with an explicit virtual environment path.
9. **pyproject.toml Creation**: Creates a `pyproject.toml` file with local dependencies and the virtual environment path.
10. **Environment Setup**: Sets up the virtual environment, installs dependencies, and activates the environment.
11. **Open VSCode**: Opens the project in Visual Studio Code.

The resulting project structure looks like this:


floris_loads/ ├── .gitignore ├── pyproject.toml ├── setup-script-uv.sh ├── init.py └── modules/ ├── floris/ └── flasc/