# Fedora KDE Setup Script 🚀

---

This repository contains scripts and configurations to automate the setup of a **Fedora KDE** system. It includes tools for system configuration, development, and productivity, as well as scripts for setting up GitHub SSH authentication. Additionally, it provides **dotfiles** for customizing your system, which can be easily managed using **GNU Stow**.
Perfect for fresh Fedora installations! 🎉


---

## Repository Structure 📂


```
├── Fedora KDE Setup
│   ├── automted_script.sh          # Main script for Fedora KDE setup
│   ├── Dotfiles                    # Directory for dotfiles
│   │   ├── bashrc                  # Bash configuration file
│   │   ├── fastfetch               # Fastfetch configuration
│   │   ├── Hyper                   # Hyper terminal configuration
│   │   └── tmux                    # Tmux configuration
│   ├── githubSSH.sh                # Script for GitHub SSH setup
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
wget https://raw.githubusercontent.com/yourusername/fedora-kde-setup/main/automated.sh
```

### 2. Make the Script Executable
```bash
chmod +x automated.sh
```

### 3. Run the Script
```bash
./automated.sh
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


## `githubSSH.sh` Script 🔐

This script automates the process of setting up SSH authentication for GitHub. It generates an SSH key (if one doesn't already exist), adds it to the SSH agent, and guides you through adding the key to your GitHub account.

---

### Features ✨

- **SSH Key Generation**: Generates a new SSH key using the `ed25519` algorithm. 🔑
- **SSH Agent Setup**: Adds the SSH key to the SSH agent for seamless authentication. 🔒
- **GitHub Integration**: Opens the GitHub SSH settings page in your browser for easy key addition. 🌐
- **Authentication Test**: Tests the SSH connection to GitHub to ensure everything is working. ✅
- **Cleanup Suggestions**: Provides tips for cleaning up unnecessary files. 🗑️

---

### How to Use 🛠️

1. **Run the Script**:
   ```bash
   ./githubSSH.sh
   ```

2. **Enter Your GitHub Email**:
   The script will prompt you to enter your GitHub email address. This email will be used to generate the SSH key.

3. **Generate SSH Key**:
   If no SSH key is found, the script will generate a new one. If a key already exists, it will use the existing key.

4. **Add SSH Key to GitHub**:
   The script will display your SSH public key and open the GitHub SSH settings page in your browser. Copy and paste the public key into GitHub.

5. **Test Authentication**:
   The script will test the SSH connection to GitHub. If successful, you'll see a confirmation message.

6. **Cleanup**:
   The script will suggest deleting unnecessary files like `known_hosts.old`.

---

### Code Explanation 🧑‍💻

#### 1. **ASCII Art Banner**
Displays a banner for the script:
```bash
echo """
====================================
  GitHub SSH Key Setup & Login Script
====================================
"""
```

#### 2. **Prompt for GitHub Email**
Prompts the user to enter their GitHub email:
```bash
echo "Enter your GitHub email address: "
read email
```

#### 3. **Check for Existing SSH Key**
Checks if an SSH key already exists:
```bash
if [ -f "$PRIVATE_KEY" ] && [ -f "$PUBLIC_KEY" ]; then
    echo "🔑 SSH keys found! Using existing key for authentication."
else
    echo "🚀 No SSH key found. Generating a new SSH key..."
    ssh-keygen -t ed25519 -C "$email" -f "$PRIVATE_KEY" -N ""
    echo "✅ SSH key generated successfully!"
fi
```

#### 4. **Add Key to SSH Agent**
Adds the SSH key to the SSH agent:
```bash
eval "$(ssh-agent -s)"
ssh-add "$PRIVATE_KEY"
```

#### 5. **Display SSH Public Key**
Displays the SSH public key for the user to copy:
```bash
echo "📋 Copy the following SSH public key and add it to your GitHub SSH settings:"
cat "$PUBLIC_KEY"
```

#### 6. **Open GitHub SSH Settings**
Opens the GitHub SSH settings page in the default browser:
```bash
x-www-browser "https://github.com/settings/keys" 2>/dev/null || xdg-open "https://github.com/settings/keys" 2>/dev/null || open "https://github.com/settings/keys"
```

#### 7. **Test SSH Authentication**
Tests the SSH connection to GitHub:
```bash
ssh -T git@github.com
if [ $? -eq 1 ]; then
    echo "⚠️ Authentication failed! Please make sure you have added your SSH key to GitHub."
else
    echo "✅ Authentication successful! You can now use SSH for GitHub."
fi
```

#### 8. **Cleanup Suggestions**
Suggests cleaning up unnecessary files:
```bash
echo "🗑️ If you want, you can delete the known_hosts.old file safely."
rm -i "$SSH_DIR/known_hosts.old"
```

---

### Important Notes 📝

- **Private Key Security**:
  - ❌ Never share your private key (`id_ed25519`).
  - ✅ Share your public key (`id_ed25519.pub`) when needed (e.g., for GitHub SSH setup).

- **File Cleanup**:
  - 🗑️ You can safely delete `known_hosts.old` after testing your SSH connection.
  - 🔐 Keep the `known_hosts` file unless you face SSH issues.

---

### Example Output 🖥️

```
====================================
  GitHub SSH Key Setup & Login Script
====================================

Enter your GitHub email address: user@example.com
🚀 No SSH key found. Generating a new SSH key...
✅ SSH key generated successfully!
📋 Copy the following SSH public key and add it to your GitHub SSH settings:
----------------------------------------
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJz3... user@example.com
----------------------------------------
🌍 Opening GitHub SSH settings page in your browser...
🔄 Attempting to authenticate with GitHub...
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
✅ Authentication successful! You can now use SSH for GitHub.
🗑️ If you want, you can delete the known_hosts.old file safely.
🎉 Setup complete! You can now use GitHub with SSH.
```

---

## License 📄
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

Enjoy seamless GitHub SSH authentication! 🚀

---

---

## Using GNU Stow to Manage Dotfiles 🗂️

**GNU Stow** is a symlink manager that helps you organize and manage your dotfiles. It creates symlinks from your dotfiles directory to your home directory, making it easy to version control and deploy your configurations.

---

### How to Use Stow 🛠️

#### 1. **Install Stow**
If you haven't already installed Stow, you can do so using:
```bash
sudo dnf install stow
```

#### 2. **Clone This Repository**
Clone the repository to your home directory (or any desired location):
```bash
git clone https://github.com/yourusername/fedora-kde-setup.git ~/fedora-kde-setup
```

#### 3. **Navigate to the Dotfiles Directory**
Move into the `Dotfiles` directory:
```bash
cd ~/fedora-kde-setup/Dotfiles
```

#### 4. **Stow the Dotfiles**
Use Stow to symlink the dotfiles to your home directory. For example:
```bash
stow bashrc       # Symlink .bashrc
stow fastfetch    # Symlink Fastfetch config
stow Hyper        # Symlink Hyper config
stow tmux         # Symlink Tmux config
```

You can also symlink all dotfiles at once:
```bash
stow .
```

#### 5. **Verify the Symlinks**
Check that the symlinks have been created in your home directory:
```bash
ls -la ~
```
You should see symlinks like:
```
.bashrc -> ~/fedora-kde-setup/Dotfiles/bashrc/.bashrc
.config/fastfetch -> ~/fedora-kde-setup/Dotfiles/fastfetch/.config/fastfetch
.config/Hyper -> ~/fedora-kde-setup/Dotfiles/Hyper/.config/Hyper
.tmux.conf -> ~/fedora-kde-setup/Dotfiles/tmux/.tmux.conf
```

---

### Dotfiles Included in This Repository 📜

#### 1. **`.bashrc`**
Customizes your Bash shell with aliases, environment variables, and prompt settings.

#### 2. **Fastfetch**
A configuration file for **Fastfetch**, a system information tool. Displays system stats in a clean and colorful format.

#### 3. **Hyper**
Configuration for the **Hyper Terminal**, including themes, plugins, and keybindings.

#### 4. **Tmux**
Configuration for **Tmux**, including keybindings, status bar customization, and plugin management.

---

### Example: Stowing Tmux Configuration 🖥️

1. Navigate to the `Dotfiles` directory:
   ```bash
   cd ~/fedora-kde-setup/Dotfiles
   ```

2. Stow the `tmux` configuration:
   ```bash
   stow tmux
   ```

3. Verify the symlink:
   ```bash
   ls -la ~/.tmux.conf
   ```
   Output:
   ```
   .tmux.conf -> ~/fedora-kde-setup/Dotfiles/tmux/.tmux.conf
   ```

4. Start Tmux and enjoy your customized setup:
   ```bash
   tmux
   ```

---

### Unstowing Dotfiles 🗑️

If you want to remove the symlinks and revert to your original configuration, use the `-D` flag with Stow:
```bash
stow -D bashrc       # Remove .bashrc symlink
stow -D fastfetch    # Remove Fastfetch config symlink
stow -D Hyper        # Remove Hyper config symlink
stow -D tmux         # Remove Tmux config symlink
```

To remove all symlinks at once:
```bash
stow -D .
```

---

### Why Use Stow? 🤔

- **Version Control**: Easily track changes to your dotfiles using Git.
- **Portability**: Deploy your configurations on multiple systems with a single command.
- **Simplicity**: No need to manually create symlinks or copy files.

---

## License 📄
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

Enjoy your beautifully customized system! 🎉
---
