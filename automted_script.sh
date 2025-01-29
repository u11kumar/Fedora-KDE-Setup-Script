#!/bin/bash

# ASCII Art Header
echo -e "\e[1;34m"
cat << "EOF"

 __          __         _
 \ \        / /        | |
  \ \  /\  / /    ___  | |   ___    ___    _ __ ___     ___
   \ \/  \/ /    / _ \ | |  / __|  / _ \  | '_ ` _ \   / _ \
    \  /\  /    |  __/ | | | (__  | (_) | | | | | | | |  __/
     \/  \/      \___| |_|  \___|  \___/  |_| |_| |_|  \___|


 /$$   /$$ /$$      /$$ /$$$$$$$$  /$$$$$$  /$$   /$$       /$$   /$$ /$$   /$$ /$$      /$$  /$$$$$$  /$$$$$$$
| $$  | $$| $$$    /$$$| $$_____/ /$$__  $$| $$  | $$      | $$  /$$/| $$  | $$| $$$    /$$$ /$$__  $$| $$__  $$
| $$  | $$| $$$$  /$$$$| $$      | $$  \__/| $$  | $$      | $$ /$$/ | $$  | $$| $$$$  /$$$$| $$  \ $$| $$  \ $$
| $$  | $$| $$ $$/$$ $$| $$$$$   |  $$$$$$ | $$$$$$$$      | $$$$$/  | $$  | $$| $$ $$/$$ $$| $$$$$$$$| $$$$$$$/
| $$  | $$| $$  $$$| $$| $$__/    \____  $$| $$__  $$      | $$  $$  | $$  | $$| $$  $$$| $$| $$__  $$| $$__  $$
| $$  | $$| $$\  $ | $$| $$       /$$  \ $$| $$  | $$      | $$\  $$ | $$  | $$| $$\  $ | $$| $$  | $$| $$  \ $$
|  $$$$$$/| $$ \/  | $$| $$$$$$$$|  $$$$$$/| $$  | $$      | $$ \  $$|  $$$$$$/| $$ \/  | $$| $$  | $$| $$  | $$
 \______/ |__/     |__/|________/ \______/ |__/  |__/      |__/  \__/ \______/ |__/     |__/|__/  |__/|__/  |__/


EOF
echo -e "\e[0m"

echo "Welcome to Fedora Setup Script!"

echo "Would you like to create a system backup before proceeding with the setup? (yes/no)"
read backup_choice

if [[ $backup_choice == "yes" ]]; then
  echo "Checking if Timeshift is installed..."
  if ! command -v timeshift &> /dev/null; then
    echo "Installing Timeshift..."
    sudo dnf install timeshift -y
  else
    echo "Timeshift is already installed!"
  fi

  echo "Creating backup directory at ~/Backup..."
  mkdir -p ~/Backup

  echo "Creating system backup using Timeshift..."
  sudo timeshift --create --target "/home/$(whoami)/Backup"

  echo "Listing backups..."
  sudo timeshift --list

  echo "Setting up automated backup schedule..."
  sudo timeshift --schedule
  echo "Backup process completed! You can proceed with the setup now."
else
  echo "Skipping backup process and proceeding with the setup..."
fi

# Updating and upgrading system packages
echo "Updating system packages..."
sudo dnf update -y && sudo dnf upgrade -y

# Running migration script for UltraMarine Linux
echo "Running UltraMarine Linux migration script..."
bash <(curl -s https://ultramarine-linux.org/migrate.sh)

# List of packages to install
packages=(
  stow          # Manage dotfiles
  vlc           # Media player
  wget          # Download tool
  git           # Version control
  curl          # HTTP requests
  neovim        # Text editor
  kate          # KDE Advanced Text Editor
  dolphin       # KDE File Manager
  konsole       # KDE Terminal Emulator
  spectacle     # KDE Screenshot Tool
  ark           # KDE Archiving Tool
  gwenview      # KDE Image Viewer
  stacer        # System Monitoring App
  fastfetch     # Fastfetch
  bat           # cat clone with syntax highlighting and Git integration
  fzf           # fzf is a general-purpose command-line fuzzy finder
  kitty         # Kitty Terminal
)


# Install packages
for package in "${packages[@]}"; do
  if ! rpm -q $package &> /dev/null; then
    echo "Installing $package..."
    if sudo dnf install $package -y; then
      echo "$package installed successfully."
    else
      echo "Error: Failed to install $package."
    fi
  else
    echo "$package is already installed! Skipping..."
  fi
done

echo "Software installation process completed."

# Installing fonts for terminal customization
echo "Installing MesloLGSNF and font manager..."
sudo bash -c "$(curl -LSs https://github.com/dfmgr/installer/raw/main/install.sh)"
bash -c "$(curl -LSs https://github.com/fontmgr/MesloLGSNF/raw/main/install.sh)"




# Installing and setting up Zsh with Oh My Zsh
echo "Checking and Installing Zsh and Oh My Zsh..."

if ! command -v zsh &> /dev/null; then
  echo "Installing Zsh..."
  sudo dnf install zsh -y
else
  echo "Zsh is already installed!"
fi

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed! Skipping..."
fi

# Installing Powerlevel10k for Zsh theme
echo "Installing Powerlevel10k theme for Zsh..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"


# Define the path to the .zshrc file
ZSHRC_FILE="$HOME/.zshrc"

# Check if the .zshrc file exists
if [ -f "$ZSHRC_FILE" ]; then
    # Use sed to find and replace the ZSH_THEME line and create a backup
    sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC_FILE"
    echo "Updated ZSH_THEME in $ZSHRC_FILE to 'powerlevel10k/powerlevel10k'."
    echo "A backup of the original .zshrc file has been created as $ZSHRC_FILE.bak."
else
    echo "Error: $ZSHRC_FILE does not exist."
fi





fi

# Installing Hyper Terminal
echo "Checking and Installing Hyper Terminal..."
if ! command -v hyper &> /dev/null; then
  wget https://github.com/vercel/hyper/releases/download/v3.4.1/hyper-3.4.1.x86_64.rpm -P ~/Downloads
  sudo dnf install ~/Downloads/hyper-3.4.1.x86_64.rpm -y
else
  echo "Hyper Terminal is already installed!"
fi




# Installing Visual Studio Code
echo "Checking and Installing Visual Studio Code..."
if ! command -v code &> /dev/null; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
  sudo dnf install code -y
else
  echo "Visual Studio Code is already installed!"
fi

# Installing Node.js
echo "Checking and Installing Node.js..."
if ! command -v node &> /dev/null; then
  sudo dnf install nodejs -y
  echo "Node.js version: $(node --version)"
else
  echo "Node.js is already installed!"
fi

# Installing Kickstart Neovim distribution
echo "Installing Kickstart Neovim distribution..."
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# Installing Ruby with RVM
echo "Installing Ruby..."
gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --rails

# Installing Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update


# Adding Flathub repository
echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo


# Automatically answer 'yes' for all flatpak installs
FLATPAK_YES='--assumeyes'

flatpak install $FLATPAK_YES flathub org.jdownloader.JDownloader
flatpak install $FLATPAK_YES flathub org.qbittorrent.qBittorrent
flatpak install $FLATPAK_YES flathub io.github.giantpinkrobots.varia
flatpak install $FLATPAK_YES flathub org.onlyoffice.desktopeditors
flatpak install $FLATPAK_YES flathub io.github.kukuruzka165.materialgram
flatpak install $FLATPAK_YES flathub com.brave.Browser
flatpak install $FLATPAK_YES flathub io.github.josephmawa.Egghead
flatpak install $FLATPAK_YES flathub io.github.cleomenezesjr.Escambo
flatpak install $FLATPAK_YES flathub rest.insomnia.Insomnia
flatpak install $FLATPAK_YES flathub us.materialio.Materialious
flatpak install $FLATPAK_YES flathub app.zen_browser.zen
flatpak install $FLATPAK_YES flathub com.github.huluti.Curtail

# Optional installations: Whaler (for Docker) and Freelens (for Kubernetes)
read -p "Do you want to install Whaler (for Docker)? (yes/no): " install_whaler
install_whaler=${install_whaler,,}  # Convert input to lowercase

if [[ "$install_whaler" == "y" || "$install_whaler" == "yes" ]]; then
  flatpak install $FLATPAK_YES flathub com.github.sdv43.whaler
elif [[ "$install_whaler" == "n" || "$install_whaler" == "no" ]]; then
  echo "Skipping Whaler installation."
else
  echo "Invalid input. Please enter yes or no."
fi

read -p "Do you want to install Freelens (for Kubernetes)? (yes/no): " install_freelens
install_freelens=${install_freelens,,}
if [[ "$install_freelens" == "y" || "$install_freelens" == "yes" ]]; then
  flatpak install $FLATPAK_YES flathub app.freelens.Freelens
elif [[ "$install_freelens" == "n" || "$install_freelens" == "no" ]]; then
  echo "Skipping Freelens installation."
else
  echo "Invalid input. Please enter yes or no."
fi

echo -e "\e[1;32m"
cat << "EOF"



███████╗██╗███╗   ██╗██╗███████╗██╗  ██╗███████╗██████╗
██╔════╝██║████╗  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗
█████╗  ██║██╔██╗ ██║██║███████╗███████║█████╗  ██║  ██║
██╔══╝  ██║██║╚██╗██║██║╚════██║██╔══██║██╔══╝  ██║  ██║
██║     ██║██║ ╚████║██║███████║██║  ██║███████╗██████╔╝
╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═════╝


EOF
echo -e "\e[0m"
echo "All installations are completed! Please restart your terminal or system for the changes to take effect."
exit 0



# Installing Modern Clock for KDE
# A modern looking clock widget!
# Clone this repository
git clone https://github.com/prayag2/kde_modernclock && cd kde_modernclock/
# Install using the script
kpackagetool5 -i package



# download the master folder in Downloads folder
wget https://github.com/dracula/kitty/archive/master.zip
cp dracula.conf diff.conf ~/.config/kitty/
echo "include dracula.conf" >> ~/.config/kitty/kitty.conf


