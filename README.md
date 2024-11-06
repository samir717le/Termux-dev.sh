# Termux All-in-One Developer Setup Script

This script automates the setup of a complete development environment in Termux, including essential development tools, graphical user interface (GUI) support, and customization of the terminal environment.

## Key Features

1. **Installs Essential Developer Tools**:
   - Git, Node.js, Python, PHP, Ruby, and many more development tools.
   - Compilers and build systems: Clang, CMake, Make, etc.
   - Database support: SQLite, MySQL (MariaDB), PostgreSQL.
   - Utilities: Curl, Wget, HTTPie, jq, etc.

2. **Sets Up VNC Server with Xfce Desktop**:
   - Installs `tigervnc` and Xfce desktop environment for graphical support.
   - Installs additional GUI tools like `xfce4-terminal`, `leafpad`, and `thunar` (file manager).
   - Automatically configures the VNC server to run on display `:1`.

3. **Customizes `.bashrc`**:
   - Stylish, programmer-friendly prompt.
   - Useful aliases for updating and managing the system.
   - Auto-configures the `DISPLAY` environment variable to `:1` for GUI apps.

4. **Adds `dev-start` Command**:
   - Starts the VNC server with the Xfce desktop environment.
   - Updates and upgrades all Termux packages.
   - Fixes any broken packages and configures the system.
   - Ensures that the `DISPLAY` variable is correctly set for graphical apps.

5. **Installs Additional Apps**:
   - Installs popular applications from the Termux User Repository (`tur-repo`), such as:
     - **VS Code (`code-oss`)**
     - **Firefox**
     - **Chromium**

6. **Final Cleanup**:
   - Cleans up unnecessary files.
   - Ensures that any broken packages are fixed.
   - Ensures the Termux environment is ready for development after running the script.

## Installation Instructions

1. **Save the script** as `setup-full-dev-env.sh`.
2. **Make the script executable**:
   ```bash
   chmod +x setup-full-dev-env.sh
