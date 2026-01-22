{ ... }:
{
  imports = [
    ./audacious/audacious.nix         # music player
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./cava.nix                        # audio visualizer
    ./discord.nix                     # discord
    ./fastfetch/fastfetch.nix         # fetch tool
    ./fzf.nix                         # fuzzy finder
    ./git.nix                         # version control
    ./gnome.nix                       # gnome apps
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./kitty.nix                       # terminal
    ./lazygit.nix
    ./nemo.nix                        # file manager
    ./nvim.nix                        # neovim editor
    ./obsidian.nix
    ./packages                        # other packages
    ./rofi/rofi.nix                   # launcher
    ./../../scripts/scripts.nix       # personal scripts
    ./ssh.nix                         # ssh config
    ./spicetify.nix                   # spotify client
    ./superfile/superfile.nix         # terminal file manager
    ./swaylock.nix                    # lock screen
    ./swayosd.nix                     # brightness / volume wiget
    ./swaync/swaync.nix               # notification deamon
    ./waybar                          # status bar
    ./waypaper.nix                    # GUI wallpaper picker
    ./xdg-mimes.nix                   # xdg config
    ./zsh                             # shell
    ./protonmail.nix		      # mail app
  ];
}
