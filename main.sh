#!/data/data/com.termux/files/usr/bin/bash

# Function to install a package if it's not already installed
install_if_missing() {
  if ! dpkg -s "$1" &> /dev/null; then
    echo "Installing $1..."
    pkg install -y "$1"
  else
    echo "$1 is already installed."
  fi
}

# Function to add dev-start command
add_dev_start_command() {
  echo "Creating dev-start command..."
  cat << 'EOF' > ~/dev-start.sh
#!/data/data/com.termux/files/usr/bin/bash
# dev-start: Start VNC server, update packages, fix broken packages, set DISPLAY

echo "Starting VNC server..."
vncserver -localhost -geometry 1280x720 :1

# Set the DISPLAY environment variable for GUI apps
export DISPLAY=":1"

echo "Updating all packages and fixing broken dependencies..."
pkg update -y && pkg upgrade -y
pkg autoclean && pkg clean
dpkg --configure -a
apt --fix-broken install -y

echo -e "\nVNC server started on display $DISPLAY with resolution 1280x720."
echo "You can connect via localhost$DISPLAY in a VNC viewer app."
EOF
  chmod +x ~/dev-start.sh
  echo 'alias dev-start="~/dev-start.sh"' >> ~/.bashrc
}

# Function to customize .bashrc with a clean, programmer-friendly prompt
customize_bashrc() {
  echo "Customizing .bashrc with a stylish prompt..."
  cat << 'EOF' >> ~/.bashrc

# Clean, programmer-themed prompt
PS1='\033[1;34m\u@\h:\033[1;32m\w\033[0m $ '

# Additional developer-friendly aliases
alias update-all="pkg update -y && pkg upgrade -y && apt autoremove -y"
alias start-vnc="vncserver -localhost -geometry 1280x720 :1"
alias stop-vnc="vncserver -kill :1"
EOF
}

# Step 1: Check and fix broken packages
echo "Checking for broken packages..."
pkg autoclean && pkg clean
dpkg --configure -a
apt --fix-broken install -y

# Step 2: Update and upgrade Termux packages
echo "Updating and upgrading packages..."
pkg update -y && pkg upgrade -y

# Step 3: Add x11-repo and tur-repo (Termux User Repository for Ubuntu-compatible apps)
echo "Adding x11-repo and tur-repo..."
install_if_missing x11-repo           # Install x11 repository
install_if_missing tur-repo           # Install tur repository (for Ubuntu-compatible apps)
pkg update

# Step 4: Install VNC server, Xfce, and essential GUI tools
echo "Installing VNC server and desktop environment..."
install_if_missing tigervnc            # VNC server
install_if_missing xfce4               # Xfce desktop environment
install_if_missing xfce4-terminal      # Xfce terminal
install_if_missing leafpad             # Simple text editor
install_if_missing thunar              # File manager

# Step 5: Install core developer tools
echo "Installing development languages and tools..."
install_if_missing git                 # Version control
install_if_missing gh                  # GitHub CLI
install_if_missing python              # Python
install_if_missing nodejs              # Node.js and npm
install_if_missing php                 # PHP
install_if_missing ruby                # Ruby
install_if_missing clang               # C/C++ compiler
install_if_missing cmake               # Build system
install_if_missing make                # Build automation
install_if_missing openssl             # SSL toolkit
install_if_missing curl                # Data transfer utility
install_if_missing wget                # File download utility
install_if_missing sqlite              # Lightweight database
install_if_missing mariadb             # MySQL-compatible database
install_if_missing postgresql          # PostgreSQL database
install_if_missing jq                  # JSON processor
install_if_missing httpie              # HTTP requests
install_if_missing htop                # System monitor
install_if_missing tmux                # Terminal multiplexing
install_if_missing screen              # Terminal sessions
install_if_missing zip                 # Zip compression
install_if_missing unzip               # Unzip tool

# Step 6: Install additional developer applications from tur-repo
echo "Installing additional applications from tur-repo..."
install_if_missing code-oss            # VS Code (from tur-repo)
install_if_missing firefox             # Firefox browser (from tur-repo)
install_if_missing chromium            # Chromium browser (from tur-repo)

# Step 7: Set up VNC password (if not already set)
if [ ! -f ~/.vnc/passwd ]; then
  echo "Setting up VNC password..."
  vncserver -localhost :1
  vncserver -kill :1
else
  echo "VNC password is already set."
fi

# Step 8: Configure VNC startup script
echo "Configuring VNC startup script..."
mkdir -p ~/.vnc
cat << 'EOF' > ~/.vnc/xstartup
#!/data/data/com.termux/files/usr/bin/bash
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# Step 9: Set up dev-start command and customize .bashrc
add_dev_start_command
customize_bashrc

# Final cleanup and checking for additional broken packages
echo "Cleaning up and checking for any remaining issues..."
pkg autoclean && pkg clean
dpkg --configure -a
apt --fix-broken install -y

echo "Setup complete. Your Termux environment is ready for development!"
