#!/bin/bash

# ASCII Art Banner
echo """
====================================
  GitHub SSH Key Setup & Login Script
====================================
"""

# Prompt user for their GitHub email
echo "Enter your GitHub email address: "
read email

# Check if SSH keys exist
SSH_DIR="$HOME/.ssh"
PRIVATE_KEY="$SSH_DIR/id_ed25519"
PUBLIC_KEY="$PRIVATE_KEY.pub"

if [ -f "$PRIVATE_KEY" ] && [ -f "$PUBLIC_KEY" ]; then
    echo "🔑 SSH keys found! Using existing key for authentication."
else
    echo "🚀 No SSH key found. Generating a new SSH key..."
    ssh-keygen -t ed25519 -C "$email" -f "$PRIVATE_KEY" -N ""
    echo "✅ SSH key generated successfully!"
fi

# Add key to ssh-agent
eval "$(ssh-agent -s)"
ssh-add "$PRIVATE_KEY"

# Display the SSH public key for the user
echo "📋 Copy the following SSH public key and add it to your GitHub SSH settings:"
echo "----------------------------------------"
cat "$PUBLIC_KEY"
echo "----------------------------------------"

echo "🌍 Opening GitHub SSH settings page in your browser..."
x-www-browser "https://github.com/settings/keys" 2>/dev/null || xdg-open "https://github.com/settings/keys" 2>/dev/null || open "https://github.com/settings/keys"

echo "🔄 Attempting to authenticate with GitHub..."
ssh -T git@github.com

if [ $? -eq 1 ]; then
    echo "⚠️ Authentication failed! Please make sure you have added your SSH key to GitHub."
else
    echo "✅ Authentication successful! You can now use SSH for GitHub."
fi

# Suggest cleanup of unnecessary files
echo "🗑️ If you want, you can delete the known_hosts.old file safely."
rm -i "$SSH_DIR/known_hosts.old"

echo "🎉 Setup complete! You can now use GitHub with SSH."


echo "    ❌ Never share id_ed25519 (private key)."
echo "    ✅ Share id_ed25519.pub (public key) when needed (e.g., for GitHub SSH setup)."
echo "    🗑️ You can delete known_hosts.old after testing your SSH connection."
echo "    🔐 Keep known_hosts unless you face SSH issues."
