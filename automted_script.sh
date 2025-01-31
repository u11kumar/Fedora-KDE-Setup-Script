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

echo -e "\e[1;32mWelcome to Fedora Setup Script!\e[0m"

# Function to check if a package is installed
is_package_installed() {
  if rpm -q "$1" &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Backup System
echo -e "\e[1;33mWould you like to create a system backup before proceeding with the setup? (yes/no)\e[0m"
read backup_choice

if [[ $backup_choice == "yes" ]]; then
  echo -e "\e[1;34mChecking if Timeshift is installed...\e[0m"
  if ! command -v timeshift &> /dev/null; then
    echo -e "\e[1;32mInstalling Timeshift...\e[0m"
    sudo dnf install timeshift -y
  else
    echo -e "\e[1;32mTimeshift is already installed!\e[0m"
  fi

  echo -e "\e[1;34mCreating backup directory at ~/Backup...\e[0m"
  mkdir -p ~/Backup

  echo -e "\e[1;34mCreating system backup using Timeshift...\e[0m"
  sudo timeshift --create --target "/home/$(whoami)/Backup"

  echo -e "\e[1;34mListing backups...\e[0m"
  sudo timeshift --list

  echo -e "\e[1;34mSetting up automated backup schedule...\e[0m"
  sudo timeshift --schedule
  echo -e "\e[1;32mBackup process completed! You can proceed with the setup now.\e[0m"
else
  echo -e "\e[1;33mSkipping backup process and proceeding with the setup...\e[0m"
fi

# Update System
echo -e "\e[1;34mUpdating system packages...\e[0m"
sudo dnf update -y && sudo dnf upgrade -y

# Run UltraMarine Linux Migration Script
echo -e "\e[1;34mRunning UltraMarine Linux migration script...\e[0m"
bash <(curl -s https://ultramarine-linux.org/migrate.sh)

# Install Essential Packages
echo -e "\e[1;34mInstalling essential packages...\e[0m"
packages=(
  stow vlc wget git curl neovim
  kate dolphin konsole spectacle ark gwenview
  stacer fastfetch bat fzf kitty
)

for package in "${packages[@]}"; do
  if ! is_package_installed "$package"; then
    echo -e "\e[1;32mInstalling $package...\e[0m"
    sudo dnf install "$package" -y
  else
    echo -e "\e[1;33m$package is already installed! Skipping...\e[0m"
  fi
done

# Install Fonts
echo -e "\e[1;34mInstalling MesloLGSNF and font manager...\e[0m"
sudo bash -c "$(curl -LSs https://github.com/dfmgr/installer/raw/main/install.sh)"
bash -c "$(curl -LSs https://github.com/fontmgr/MesloLGSNF/raw/main/install.sh)"

# Install Zsh and Oh My Zsh
echo -e "\e[1;34mInstalling Zsh and Oh My Zsh...\e[0m"
if ! command -v zsh &> /dev/null; then
  echo -e "\e[1;32mInstalling Zsh...\e[0m"
  sudo dnf install zsh -y
else
  echo -e "\e[1;33mZsh is already installed!\e[0m"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo -e "\e[1;32mInstalling Oh My Zsh...\e[0m"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo -e "\e[1;33mOh My Zsh is already installed! Skipping...\e[0m"
fi



# Update .zshrc with Powerlevel10k Theme
ZSHRC_FILE="$HOME/.zshrc"
if [ -f "$ZSHRC_FILE" ]; then
  echo -e "\e[1;34mUpdating ZSH_THEME in .zshrc to 'powerlevel10k/powerlevel10k'...\e[0m"
  sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC_FILE"
  echo -e "\e[1;32mUpdated ZSH_THEME in $ZSHRC_FILE to 'powerlevel10k/powerlevel10k'.\e[0m"
  echo -e "\e[1;33mA backup of the original .zshrc file has been created as $ZSHRC_FILE.bak.\e[0m"
else
  echo -e "\e[1;31mError: $ZSHRC_FILE does not exist.\e[0m"
fi

# Install Hyper Terminal
echo -e "\e[1;34mInstalling Hyper Terminal...\e[0m"
if ! command -v hyper &> /dev/null; then
  wget https://github.com/vercel/hyper/releases/download/v3.4.1/hyper-3.4.1.x86_64.rpm -P ~/Downloads
  sudo dnf install ~/Downloads/hyper-3.4.1.x86_64.rpm -y
else
  echo -e "\e[1;33mHyper Terminal is already installed!\e[0m"
fi

if ! command -v jdownloader &> /dev/null; then

else
  echo -e "\e[1;33mJdownloader  is already installed!\e[0m"
fi



# Install Visual Studio Code
echo -e "\e[1;34mInstalling Visual Studio Code...\e[0m"
if ! command -v code &> /dev/null; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
  sudo dnf install code -y
else
  echo -e "\e[1;33mVisual Studio Code is already installed!\e[0m"
fi

# Install Node.js
echo -e "\e[1;34mInstalling Node.js...\e[0m"
if ! command -v node &> /dev/null; then
  sudo dnf install nodejs -y
  echo -e "\e[1;32mNode.js version: $(node --version)\e[0m"
else
  echo -e "\e[1;33mNode.js is already installed!\e[0m"
fi

# Install Kickstart Neovim
echo -e "\e[1;34mInstalling Kickstart Neovim distribution...\e[0m"
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# Install Ruby with RVM
echo -e "\e[1;34mInstalling Ruby...\e[0m"
gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --rails

# Install Rust
echo -e "\e[1;34mInstalling Rust...\e[0m"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

# Install Flatpak Apps
echo -e "\e[1;34mInstalling Flatpak apps...\e[0m"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

FLATPAK_APPS=(
  org.jdownloader.JDownloader
  org.qbittorrent.qBittorrent
  io.github.giantpinkrobots.varia
  org.onlyoffice.desktopeditors
  io.github.kukuruzka165.materialgram
  com.brave.Browser
  io.github.josephmawa.Egghead
  io.github.cleomenezesjr.Escambo
  rest.insomnia.Insomnia
  us.materialio.Materialious
  app.zen_browser.zen
  com.github.huluti.Curtail
)

for app in "${FLATPAK_APPS[@]}"; do
  if ! flatpak list | grep -q "$app"; then
    echo -e "\e[1;32mInstalling $app...\e[0m"
    flatpak install flathub "$app" -y
  else
    echo -e "\e[1;33m$app is already installed! Skipping...\e[0m"
  fi
done

# Optional Flatpak Installations
read -p "Do you want to install Whaler (for Docker)? (yes/no): " install_whaler
install_whaler=${install_whaler,,}
if [[ "$install_whaler" =~ ^(yes|y)$ ]]; then
  flatpak install flathub com.github.sdv43.whaler -y
else
  echo -e "\e[1;33mSkipping Whaler installation.\e[0m"
fi

read -p "Do you want to install Freelens (for Kubernetes)? (yes/no): " install_freelens
install_freelens=${install_freelens,,}
if [[ "$install_freelens" =~ ^(yes|y)$ ]]; then
  flatpak install flathub app.freelens.Freelens -y
else
  echo -e "\e[1;33mSkipping Freelens installation.\e[0m"
fi

# Installing Modern Clock for KDE
# A modern looking clock widget!
# Clone this repository
read -p "Do you want to install Modern Clock Widget? (yes/no): " install_widget
install_widget=${install_widget,,}
if [[ "$install_widget" =~ ^(yes|y)$ ]]; then
  echo  Cloning the repository
  git clone https://github.com/prayag2/kde_modernclock && cd kde_modernclock/
  echo Installing the script
  kpackagetool5 -i package
else
  echo -e "\e[1;33mSkipping Freelens installation.\e[0m"
fi


# Install Powerlevel10k Theme
read -p "Do you want to install Powerlevel10k theme for Zsh? (yes/no):  " install_powerlevel10k
install_powerlevel10k=${install_powerlevel10k,,}
if [[ "$install_powerlevel10k" =~ ^(yes|y)$ ]]; then
  echo -e "\e[1;34mInstalling Powerlevel10k theme for Zsh...\e[0m"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
else
  echo -e "\e[1;33mSkipping Powerlevel10k installation.\e[0m"
fi



# Final Message
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
echo -e "\e[1;32mAll installations are completed! Please restart your terminal or system for the changes to take effect.\e[0m"
exit 0
