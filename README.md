# Mac Setup: AeroSpace + SketchyBar

A minimalist, keyboard-centric window management setup for macOS. This configuration uses AeroSpace for tiling, SketchyBar for the status bar, and Jankyborders for active window highlighting.

This is only part of a greater keyboard-centric workflow that i have been creating within the last year for macos. 

[!IMPORTANT]
This guide provides two installation methods: Manual and GNU Stow. If you want a setup that is easy to update and sync across different machines, I highly recommend using the Stow method.

# Credits & Inspiration
Check out the original sources that helped me build this:
* **Official Documentation**: [AeroSpace Guide](https://nikitabobko.github.io/AeroSpace/guide) — The offical dociumentation for aerospace.
* **Video Walkthrough**: [Aerospace Changes Your macOS Window Management FOREVER!](https://youtu.be/gjR2eiomRwo) — Excellent for seeing the workflow in action.
* **Original Config Base**: [mehd-io/dotfiles](https://github.com/mehd-io/dotfiles) — Great reference for Sketchybar + AeroSpace integration, my config is really just a heavily modified version of this one.

# 1. Prerequisites & Dependencies

Everything is managed via Homebrew. If you don't have it installed:

```
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"

```


Core Applications

Install the main tools used in this setup:

## Add Taps
```
brew tap nikitabobko/tap
brew tap FelixKratz/formulae
```

## Install Apps
```
brew install --cask aerospace
brew install sketchybar
brew install borders
```

## Essential Fonts

SketchyBar and the terminal UI rely on specific Nerd Fonts and Apple's SF family to display icons correctly.
```
brew install --cask sf-symbols
brew install --cask font-sf-pro
brew install --cask font-sf-mono
brew install --cask font-jetbrains-mono-nerd-font
brew install sketchybar-app-font
```


# 2. Manual Installation

Use this if you just want to copy the files and get started immediately.

# Clone the repository
```
git clone [https://github.com/EjCabada/mac_setup.git](https://github.com/EjCabada/mac_setup.git) ~/mac_setup
cd ~/mac_setup
```

## Create config directory
mkdir -p ~/.config

## Copy configs to your system
```
cp -r macos/.config/aerospace ~/.config/
cp -r macos/.config/sketchybar ~/.config/
```



# 3. GNU Stow version

What is Stow?

Stow is a symlink manager. Instead of copying files, it creates "shortcuts" (links) from this folder into your ~/.config folder.

The Benefit: If you edit the files in your repo, the changes are automatically applied to your system.

Cleanliness: To uninstall, you just "unstow" it, and the links are deleted without leaving leftover files in your system.

How to use it:

## Install Stow
`brew install stow`

## From inside your ~/mac_setup directory:
The -t ~ flag tells stow to target your home directory
`stow -t ~ macos`

## More about the power of stow:
The main reason why stow is so important and for my workflow. Stow is powerful in that you can create a single directory that includes your most important apps and settings all in one place, and by including a single command in your zshrc file you can constantly sync all your settings and downlaod your whole workflow into any mac or linux machine in less than 5 minutes. 

A quick tutorial, 
first we stow the zshrc file:`stow zsh`

adding this line to your zshrc will allow the zshrc to work in linux and macOS simultaniously:
```
if [[ "$OSTYPE" == "darwin"* ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi
export PATH="$HOMEBREW_PREFIX/bin:$PATH"
```
all macos specific configs would just be added as such: 
```
if [[ "$OSTYPE" == "darwin"* ]]; then
    # add everything in here
fi
```
and most importantly adding `dotsync()` allows us to keep our config synced to github by running the command dotsync in the terminal and we have the stow directory linked to a github directory.
```
# Lazy Dotfile Sync
dotsync() {
  local current_dir=$(pwd)
  cd ~/dotfiles
  
  # Refresh Stow links (ensure ~/.zshrc is linked to the dotfiles)
  stow -R zsh
  
  # Standard Git workflow
  git add .
  git commit -m "sync: $(date +'%Y-%m-%d %H:%M:%S')"
  git push
  
  cd "$current_dir"
  echo "
```


# 4. Configuration Highlights

## AeroSpace: Ergonomic Gaps

In `~/.config/aerospace/aerospace.toml`, you will notice large outer gaps (75px) for external monitors.

```
outer.right = [{ monitor."built-in" = 5 }, 75]
outer.left = [{ monitor."built-in" = 5 }, 75]
```

Why? On a 27-inch 4K monitor, windows at the extreme edges cause neck strain. These gaps force your workspace toward the center.

How to change: To bring windows closer to the edge, change 75 to a smaller number (e.g., 15 or 0).
As such, built-in will have basically no gaps, and all other monitors will have 75. you will also notice some commented out versions, i have 2 monitors, the commented out ones have special top and bottom gaps for a vertical monitor if needed. 

## SketchyBar: Dynamic Themes!

My bar includes a built-in theme engine with 20+ presets (Tokyo Night, Gruvbox, Nord, etc.).
(I KNOW I SHOULD REFACTOR THIS, I SWEAR I'LL DO IT SOME DAY!!!)

Switch via UI: Click the Theme icon () on the bar to open the popup menu.

Switch via Code: Edit `THEME="tokyonight"` at the top of `~/.config/sketchybar/sketchybarrc`.

Bar Sizing: To adjust the bar thickness, modify height=36 in the INITIALIZATION section of the sketchybarrc.

## Jankyborders

Borders are driven directly by the SketchyBar theme engine and aerospace when firs starting out. There is no separate config file; the styling is handled via the borders command inside sketchybarrc.
I will provide the locations here: 
Aerospace: 
```
after-startup-command = [
    'exec-and-forget borders active_color=0xff00FFFF width=4.0'
]
```
SketchyBarRC (when swithcing themes):   
```
borders active_color=$ACCENT inactive_color=0x00000000 width=6.0 &
```

# 5. Starting the Environment [IMPORTANT]

Grant Accessibility Permissions in System Settings for AeroSpace and SketchyBar.

Launch the services, so that your environement is always working:

# Start background services
```
brew services start sketchybar
brew services start borders
```

# Open AeroSpace
`open -a /Applications/Aerospace.app`
