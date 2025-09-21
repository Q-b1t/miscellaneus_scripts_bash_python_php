#!/bin/bash

# --- Functions ---

# Function to display help information
show_help() {
  echo "Usage: sudo ./install.sh [OPTION]"
  echo "This script provides various setup options for the SOC 201 course."
  echo ""
  echo "Options:"
  echo "  --essentials      Installs the essential packages."
  echo "  --forensics       Installs the forensics packages."
  echo "  --upgrade         Upgrades the system packages."
  echo "  --all             Runs all setup options."
  echo "  --help            Display this help message and exit."
}

# Spinner animation function
spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  echo -n " "
  while [ "$(ps a | awk '{print $1}' | grep "$pid")" ]; do
    local temp=${spinstr#?}
    printf "%c" "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b"
  done
  printf " \b"
}

# Function to update and upgrade the system
update_system() {
  # Use ANSI escape codes for bold and green text
  echo -e "\e[1m\e[32m[*] Updating system packages...\e[0m"
  # Redirect output to /dev/null for a quieter experience
  sudo apt update -y &> /dev/null & spinner $!
  sudo apt upgrade -y &> /dev/null & spinner $!
}

# Function to install essential packages
install_essentials() {
  # Use ANSI escape codes for bold and green text
  echo -e "\e[1m\e[32m[*] Installing essential packages...\e[0m"

  declare -A packages=(
    ["git"]="git"
    ["ifconfig"]="net-tools"
    ["curl"]="curl"
    ["wget"]="wget"
    ["unzip"]="unzip"
    ["python3"]="python3"
    ["python3-venv"]="python3-venv"
    ["python3-pip"]="python3-pip"
    ["jq"]="jq"
    ["ent"]="ent"
    ["whois"]="whois"
    ["gcc"]="gcc"
    ["g++"]="g++"
    ["datamash"]="datamash"
    ["hexedit"]="hexedit"
    ["htop"]="htop"
    ["ss"]="iproute2"
    ["tcpdump"]="tcpdump"
    ["lsof"]="lsof"
    ["strings"]="binutils"
    ["dd"]="coreutils"
    ["dcfldd"]="dcfldd"
    ["hashdeep"]="hashdeep"
    ["gzip"]="gzip"
    ["openssl"]="openssl"
  )

  for cmd in "${!packages[@]}"; do
    if command -v "$cmd" &> /dev/null; then
      echo "[*] $cmd is already installed. Skipping..."
    else
      echo "[*] Installing ${packages[$cmd]}..."
      # Redirect output to /dev/null for a quieter experience
      sudo apt install -y "${packages[$cmd]}" &> /dev/null & spinner $!
    fi
  done
}

# Function to install forensic packages
install_forensics() {
  # Use ANSI escape codes for bold and green text
  echo -e "\e[1m\e[32m[*] Installing forensics packages...\e[0m"

  declare -A packages=(
    ["foremost"]="foremost"
    ["scalpel"]="scalpel"
    ["binwalk"]="binwalk"
    ["exiftool"]="libimage-exiftool-perl"
    ["yara"]="yara"
  )

  for cmd in "${!packages[@]}"; do
    if command -v "$cmd" &> /dev/null; then
      echo "[*] $cmd is already installed. Skipping..."
    else
      echo "[*] Installing ${packages[$cmd]}..."
      # Redirect output to /dev/null for a quieter experience
      sudo apt install -y "${packages[$cmd]}" &> /dev/null & spinner $!
    fi
  done
}

# --- Main Logic ---

if [ $# -eq 0 ]; then
  show_help
  exit 1
fi

case "$1" in
  --upgrade)
    update_system
    ;;
  --essentials)
    install_essentials
    ;;
  --forensics)
    install_forensics
    ;;
  --all)
    update_system
    install_essentials
    install_forensics
    ;;
  --help)
    show_help
    ;;
  *)
    echo "Invalid option. Use --help to see available options."
    show_help
    exit 1
    ;;
esac

echo ""
# Use ANSI escape codes for bold and green text
echo -e "\e[1m\e[32m[*] Setup complete! You may need to reboot the system for all changes to take effect.\e[0m"
