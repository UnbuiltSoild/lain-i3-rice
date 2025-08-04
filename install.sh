#!/bin/bash

# ========== CONFIGURATION ==========
# Author: ChatGPT
# Rice: Serial Experiments Lain (i3 version)
# Resolution: 1366x768
# Terminal: Kitty
# Info fetcher: Fastfetch

# ========== PRE-REQS ==========
echo "Installing dependencies..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm i3-wm feh kitty fastfetch picom git unzip

# ========== WALLPAPER ==========
echo "Setting up wallpaper..."
mkdir -p ~/.config/lain
curl -L -o ~/.config/lain/lain_wallpaper.png "https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/lain-i3-rice/main/lain_wallpaper.png"

# Set wallpaper using feh (invisible i3bar + fullscreen setup)
echo "feh --bg-fill ~/.config/lain/lain_wallpaper.png" >> ~/.fehbg
chmod +x ~/.fehbg

# ========== KITTY CONFIG ==========
echo "Creating Kitty config..."
mkdir -p ~/.config/kitty
cat <<EOF > ~/.config/kitty/kitty.conf
background #000000
foreground #ffffff
font_family JetBrainsMono Nerd Font
font_size 11
EOF

# ========== FASTFETCH ==========
echo "Adding Fastfetch to shell startup..."
echo "fastfetch" >> ~/.bashrc

# ========== I3 CONFIG ==========
echo "Backing up and replacing i3 config..."
mkdir -p ~/.config/i3
mv ~/.config/i3/config ~/.config/i3/config.backup 2>/dev/null
cat <<EOF > ~/.config/i3/config
set \$mod Mod4
font pango:JetBrains Mono 10

exec --no-startup-id ~/.fehbg
exec --no-startup-id kitty --class floatterm -e fastfetch

for_window [class="floatterm"] floating enable

hide_edge_borders both

# Make i3bar hidden by default
bar {
  status_command i3status
  mode hide
  hidden_state hide
  modifier none
}

# Default apps
bindsym \$mod+Return exec kitty
bindsym \$mod+d exec rofi -show run

# Basic movement
bindsym \$mod+h focus left
bindsym \$mod+j focus down
bindsym \$mod+k focus up
bindsym \$mod+l focus right

# Resize mode
bindsym \$mod+r mode "resize"
mode "resize" {
    bindsym h resize shrink width 10 px or 10 ppt
    bindsym j resize grow height 10 px or 10 ppt
    bindsym k resize shrink height 10 px or 10 ppt
    bindsym l resize grow width 10 px or 10 ppt
    bindsym Return mode "default"
}
EOF

# ========== DONE ==========
echo "All done! Logout and log back into your i3 session."
echo "Lain rice will boot with wallpaper, floating terminal, and Fastfetch."

exit 0
