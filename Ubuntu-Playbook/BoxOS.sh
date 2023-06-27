#!/bin/bash

# Exit immediately if any command fails
set -e

fire=firefox 



# Remove Firefox and snap if found 

if ! which "$fire" >> /dev/null && which snap >> /dev/null; then
    sudo snap remove $fire
    sudo apt-get remove -y snapd
fi
	

# Install Nix package manager
curl -L https://nixos.org/nix/install | sh

# Add Nix binary cache
echo "substituters = https://cache.nixos.org https://nixcache.reflex-frp.org" | sudo tee -a /etc/nix/nix.conf

# Install Flatpak
sudo apt-get install -y flatpak

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install bspwm and other packages
sudo apt-get install -y bspwm polybar sxhkd rofi xorg qutebrowser kitty

# Copy Box-store program 
sudo cp Box-store /usr/bin

# Copy config files if directories exist
if [ -d "$HOME/Downloads/BoxOS-Ubuntu/bspwm/bspwm" ]; then
  cp -r "$HOME/Downloads/BoxOS-Ubuntu/bspwm/bspwm" ~/.config
fi

if [ -d "$HOME/Downloads/BoxOS-Ubuntu/sxhkd" ]; then
  cp -r "$HOME/Downloads/BoxOS-Ubuntu/sxhkd" ~/.config
fi

if [ -d "$HOME/Downloads/BoxOS-Ubuntu/polybar/polybar" ]; then
  cp -r "$HOME/Downloads/BoxOS-Ubuntu/polybar/polybar" ~/.config
fi

if [ -d "$HOME/Downloads/BoxOS-Ubuntu/rofi" ]; then
  cp -r "$HOME/Downloads/BoxOS-Ubuntu/rofi" ~/.config
fi

echo "Script completed successfully."

# Ask user if they want to reboot or exit
read -p "Tasks completed. Do you want to reboot the system? (yes/no) " reboot_choice

if [[ $reboot_choice == "yes" ]]; then
  sudo shutdown -r now
else
  echo "Exiting..."
fi



