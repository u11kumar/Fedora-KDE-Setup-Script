

# Fedora KDE Setup Script 🚀

This repository contains scripts and configurations to automate the setup of a **Fedora KDE** system. It includes tools for system configuration, development, and productivity, as well as scripts for setting up GitHub SSH authentication. Additionally, it provides **dotfiles** for customizing your system, which can be easily managed using **GNU Stow**.

Perfect for fresh Fedora installations! 🎉

---

## Table of Contents 📑

1. [Repository Structure](#repository-structure-)
2. [Features](#features-)
3. [Packages Installed](#packages-installed-)
4. [How to Use](#how-to-use-)
5. [Code Explanation](#code-explanation-)
6. [GitHub SSH Setup](#github-ssh-setup-)
7. [Using GNU Stow for Dotfiles](#using-gnu-stow-for-dotfiles-)
8. [Suggested New Files](#suggested-new-files-)
9. [License](#license-)

---

## Repository Structure 📂

```
├── Fedora KDE Setup
│   ├── automated.sh                # Main script for Fedora KDE setup
│   ├── Dotfiles                    # Directory for dotfiles
│   │   ├── bashrc                  # Bash configuration file
│   │   ├── fastfetch               # Fastfetch configuration
│   │   ├── Hyper                   # Hyper terminal configuration
│   │   └── tmux                    # Tmux configuration
│   ├── githubSSH.sh                # Script for GitHub SSH setup
│   ├── LICENSE                     # License file
│   └── README.md                   # This README file
```

---

## Features ✨

- **System Backup**: Optionally create a system backup using Timeshift. 💾
- **Package Installation**: Installs essential packages for productivity, development, and system monitoring. 📦
- **Zsh & Oh My Zsh**: Configures Zsh with the Powerlevel10k theme for a beautiful terminal experience. 🖥️
- **Flatpak Apps**: Installs popular Flatpak apps for browsing, media, and productivity. 📱
- **Development Tools**: Sets up Node.js, Rust, Ruby, Neovim, and more. 🛠️
- **Customization**: Installs fonts, themes, and terminal tools for a personalized experience. 🎨
- **GitHub SSH Setup**: Automates GitHub SSH key generation and authentication. 🔐
- **Dotfile Management**: Uses GNU Stow to manage and deploy dotfiles. 🗂️

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

### 1. Clone the Repository
Clone the repository to your home directory:
```bash
git clone https://github.com/yourusername/fedora-kde-setup.git ~/fedora-kde-setup
```

### 2. Run the Automated Script
Navigate to the repository and run the main script:
```bash
cd ~/fedora-kde-setup
chmod +x automated.sh
./automated.sh
```

### 3. Follow the Prompts
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

---

## GitHub SSH Setup 🔐

The `githubSSH.sh` script automates the process of setting up SSH authentication for GitHub. It generates an SSH key (if one doesn't already exist), adds it to the SSH agent, and guides you through adding the key to your GitHub account.

### How to Use
1. Run the script:
   ```bash
   ./githubSSH.sh
   ```
2. Follow the prompts to generate and add your SSH key to GitHub.

---

## Using GNU Stow for Dotfiles 🗂️

**GNU Stow** is a symlink manager that helps you organize and manage your dotfiles. It creates symlinks from your dotfiles directory to your home directory, making it easy to version control and deploy your configurations.

### How to Use
1. Install Stow:
   ```bash
   sudo dnf install stow
   ```
2. Navigate to the `Dotfiles` directory:
   ```bash
   cd ~/fedora-kde-setup/Dotfiles
   ```
3. Stow the dotfiles:
   ```bash
   stow bashrc       # Symlink .bashrc
   stow fastfetch    # Symlink Fastfetch config
   stow Hyper        # Symlink Hyper config
   stow tmux         # Symlink Tmux config
   ```

---

## Suggested New Files 📄

To improve the repository, consider adding the following files:

1. **`CONTRIBUTING.md`**: Guidelines for contributing to the repository.
2. **`CHANGELOG.md`**: Track changes and updates to the scripts.
3. **`INSTALL.md`**: Detailed installation instructions.
4. **`FAQ.md`**: Frequently asked questions and troubleshooting tips.
5. **`SCREENSHOTS.md`**: Add screenshots of the setup process and final results.

---

## License 📄
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

Enjoy your beautifully customized system! 🎉

---

Let me know if you’d like further refinements or additional features! 🚀
