# Fedora KDE Setup Script 🚀

This script automates the setup of a **Fedora KDE** system, installing essential packages, configuring the environment, and setting up development tools. It also includes optional backups and Flatpak app installations. Perfect for fresh Fedora installations! 🎉

---

## Features ✨

- **System Backup**: Optionally create a system backup using Timeshift. 💾
- **Package Installation**: Installs essential packages for productivity, development, and system monitoring. 📦
- **Zsh & Oh My Zsh**: Configures Zsh with the Powerlevel10k theme for a beautiful terminal experience. 🖥️
- **Flatpak Apps**: Installs popular Flatpak apps for browsing, media, and productivity. 📱
- **Development Tools**: Sets up Node.js, Rust, Ruby, Neovim, and more. 🛠️
- **Customization**: Installs fonts, themes, and terminal tools for a personalized experience. 🎨

---

## Packages Installed 📜

### Essential Packages
- **stow**: Manage dotfiles. 🗂️
- **vlc**: Media player. 🎬
- **wget**: Download tool. ⬇️
- **git**: Version control. 🔄
- **curl**: HTTP requests. 🌐
- **neovim**: Text editor. ✍️
- **kate**: KDE Advanced Text Editor. 📝
- **dolphin**: KDE File Manager. 📁
- **konsole**: KDE Terminal Emulator. 💻
- **spectacle**: KDE Screenshot Tool. 📸
- **ark**: KDE Archiving Tool. 📦
- **gwenview**: KDE Image Viewer. 🖼️
- **stacer**: System Monitoring App. 📊
- **fastfetch**: System information tool. ℹ️
- **bat**: `cat` clone with syntax highlighting. 🐱
- **fzf**: Command-line fuzzy finder. 🔍
- **kitty**: GPU-accelerated terminal. 🐱‍💻

### Development Tools
- **Node.js**: JavaScript runtime. 🟢
- **Rust**: Systems programming language. 🦀
- **Ruby**: Dynamic programming language. 💎
- **Neovim**: Modern Vim-based text editor. 🖋️
- **Visual Studio Code**: Code editor. 🖥️
- **Hyper Terminal**: Electron-based terminal. ⚡

### Flatpak Apps
- **Brave Browser**: Privacy-focused browser. 🛡️
- **JDownloader**: Download manager. ⬇️
- **qBittorrent**: BitTorrent client. 🌊
- **OnlyOffice**: Office suite. 📄
- **Materialgram**: Telegram client. 📱
- **Insomnia**: API testing tool. 🛠️
- **Curtail**: Image compressor. 🖼️
- **Whaler**: Docker tool. 🐳 (Optional)
- **Freelens**: Kubernetes tool. ☸️ (Optional)

---

## How to Use 🛠️

### 1. Download the Script
Clone this repository or download the script:
```bash
wget https://raw.githubusercontent.com/yourusername/fedora-kde-setup/main/fedora_setup.sh
```

### 2. Make the Script Executable
```bash
chmod +x fedora_setup.sh
```

### 3. Run the Script
```bash
./fedora_setup.sh
```

### 4. Follow the Prompts
- The script will ask if you want to create a system backup. Choose `yes` or `no`.
- It will then proceed to install all packages and tools.

---

## Code Explanation 🧑‍💻

### Backup System
The script uses **Timeshift** to create a system backup if requested:
```bash
if [[ $backup_choice == "yes" ]]; then
  sudo timeshift --create --target "/home/$(whoami)/Backup"
fi
```

### Package Installation
It checks if a package is installed before installing it:
```bash
for package in "${packages[@]}"; do
  if ! rpm -q "$package" &> /dev/null; then
    sudo dnf install "$package" -y
  fi
done
```

### Zsh & Oh My Zsh
Installs and configures Zsh with the Powerlevel10k theme:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
```

### Flatpak Apps
Installs Flatpak apps from Flathub:
```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.brave.Browser -y
```

---

## Screenshots 📷

### Terminal with Powerlevel10k Theme
![Terminal](https://example.com/terminal.png)

### Flatpak Apps
![Flatpak Apps](https://example.com/flatpak.png)

---

## Contributing 🤝
Feel free to contribute to this script! Open an issue or submit a pull request.

---

## License 📄
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

Enjoy your fully configured Fedora KDE system! 🎉
