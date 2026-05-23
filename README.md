
## Layout

- [flake.nix](flake.nix) Base of the configuration
- [hosts](hosts) Per-host configurations that contain machine specific configurations
    - [desktop](hosts/desktop/) Desktop specific configuration
    - [laptop](hosts/laptop/) Laptop specific configuration
    - [vm](hosts/vm/) VM specific configuration
- [modules](modules) Modularized NixOS configurations
    - [core](modules/core/) Core NixOS configuration
    - [homes](modules/home/) My [Home-Manager](https://github.com/nix-community/home-manager) configuration
- [pkgs](pkgs) Custom packages build from source
- [scripts](scripts) Custom shell scripts
- [wallpapers](wallpapers/) Wallpapers collection

## System Components & Applications

| Component | Software |
| --- | :---: |
| **Window Manager**          | [Hyprland][Hyprland] |
| **Bar**                     | [Waybar][Waybar] |
| **Application Launcher**    | [Rofi][Rofi] |
| **Notification Daemon**     | [swaync][swaync] |
| **Terminal**                | [Kitty][Kitty] |
| **Shell**                   | [zsh][zsh] + [powerlevel10k][powerlevel10k] |
| **Text Editor**             | [Neovim][Neovim] |
| **network management tool** | [NetworkManager][NetworkManager] + [network-manager-applet][network-manager-applet] |
| **System resource monitor** | [Btop][Btop] |
| **File Manager**            | [superfile][superfile] + [nemo][nemo] |
| **Fonts**                   | [Maple Mono][Maple Mono] |
| **Color Scheme**            | [Gruvbox Dark Hard][Gruvbox] |
| **GTK theme**               | [Colloid gtk theme][Colloid gtk theme] |
| **Cursor**                  | [Bibata-Modern-Ice][Bibata-Modern-Ice] |
| **Icons**                   | [Papirus-Dark][Papirus-Dark] |
| **Lockscreen**              | [Hyprlock][Hyprlock] + [Swaylock-effects][Swaylock-effects] |
| **Image Viewer**            | [imv][imv] |
| **Media Player**            | [mpv][mpv] |
| **Music Player**            | [audacious][audacious] |
| **Screenshot Software**     | [grimblast][grimblast] |
| **Screen Recording**        | [wf-recorder][wf-recorder] + [OBS][OBS] |
| **Clipboard**               | [wl-clip-persist][wl-clip-persist] |
| **Color Picker**            | [hyprpicker][hyprpicker] |

## Custom Scripts

All of the scripts are in the [`./scripts/scripts/`](./scripts/scripts/) folder and are exported as packages in [`./scripts/scripts.nix`](./scripts/scripts.nix).

Shell scripts are automatically discovered and exported as standalone packages. The package name becomes the script base name without its extension (i.e., `ascii.sh` will become the `ascii` command).

**Note:** Scripts must have names that end with `.sh` and be tracked by git to be automatically detected.

**Since scripts are exposed as packages, you can**:
- Run them directly from the terminal (e.g., `ascii`)
- Bind them to keybindings (see [binds.nix](./modules/home/hyprland/binds.nix) for examples)
- Call them from other scripts or automation tools

**To add your own script**:
1. Add a new `.sh` file to `./scripts/scripts/`
2. Ensure it's executable (chmod +x)
3. Add it to git (git add `./scripts/scripts/<name>.sh`)
4. Rebuild your configuration (`nfs` or `nft`)
5. The script will be automatically available as a command

**Location:** [`./scripts/`](./scripts/)

```
scripts/
├── scripts/            # All shell scripts are here
│   └── <script>.sh
└── scripts.nix         # Automatic scripts packaging
```

## ⌨️ Keybinds

Keybindings are defined in [`binds.nix`](./modules/home/hyprland/binds.nix).

**Quick access:** Press `$mod F1` to view all keybinds.


| Category | Key Examples | Purpose |
|----------|--------------|---------|
| **Window Control** | `$mod + q/f/space` | close, fullscreen, float windows |
| **Media & Tools** | `Print`, `$mod + c/w` | screenshots, color picker, wallpaper picker |

# Installation

### Installation Steps

#### 1. **Install NixOS**
First, install NixOS using any [graphical ISO](https://nixos.org/download.html#nixos-iso).

*Tested with the GNOME installer using the "No desktop" option*

#### 2. **Clone the Repository**

```bash
nix-shell -p git
git clone https://github.com/Frost-Phoenix/nixos-config
cd nixos-config
```

The configuration expects the repo to be located at `$HOME/nixos-config`.

#### 3. **Run the Install Script**

```bash
./install.sh
```

The script will guide you through host selection and apply the configuration.

> [!NOTE]
> If the build gets stuck , due to RAM constraints (see [PR #30](https://github.com/Frost-Phoenix/nixos-config/pull/30)), you may need to edit the script to limit CPU cores:
>
> ```diff
> # Change in install.sh:
> - sudo nixos-rebuild switch --flake .#${HOST}
> + sudo nixos-rebuild switch --cores 4 --flake .#${HOST}
> ```

#### 4. **Reboot**

After the installation completes, reboot your system. If the installation was successful, you should be greeted by Hyprlock.

#### 5. **Post Install**

Some manual configuration is still required:

- **Aseprite Themes**: Import themes from aseprite [themes folder](./modules/home/aseprite/themes/)
- **Git Identity**: Update the [git.nix](./modules/home/git.nix) file with your name and email

```nix
programs.git = {
   ...
   userName = "<your_name>";
   userEmail = "<your_email>";
   ...
};
```

# TODO

- regarder les alias dans git.nix
- modifier la font utilisé dans le readme
- créer une branche pour la version portable de la config nix
- modifier la config hyprland pour que ça marche avec un seul écran j'ai pas envie d'avoir d'écran double
- passer sous starship avec le fichier que de mon taff
- modifier l'icone dans la waybar dans le cas ou il y a pas de fenetres actif
- remplacer winewowpackages par winewow64packages
- Modifier ROFI pour être dans le style cyberpunk
- continuer l'edit cyberpunk
- mettre le fastfetch cyberpunk dès que j'ouvre un terminal comme sur mon laptop
- voir pour le racourci pour gérer les notifications
- voir pour permettre au destop et laptop d'avoir des modules de home en commun ça doit être possible juste en créer un sous fichier onlylaptop et le mettre en appel dans laptop
- Faire un type d'host en plus pour WSL 
- Inclure ma config Neovim avec Nixvim
- Faire une config clean de Zsh avec antidote (mettre le ls comme dans mon pc du taff) (alias -g -- -h='-h 2>&1 | bat --language=help --style=plain') alias -g -- --help='--help 2>&1 | bat --language=help --style=plain') (créer una lias pour "mkdir X & cd X
- Modifier les links a la fin du readme
- vérfier les scripts existants et enlever ce que je trouve inutile
- Voir pour faire un fichier qui explique les grands points de l'utilisation de la distribution
- modifier le code pour que le choix des fonds d'écran ce fasse dans le dossier walpeper dans nixos-config
- modifier le script d'install pour pas qu'il isntal les wallpaper dans le dossier image de l'user
- https://www.nerdfonts.com/cheat-sheet
- Refracor pour les couleurs soit communes a tous les fichier 

<!-- Links -->

[Hyprland]: https://github.com/hyprwm/Hyprland
[powerlevel10k]: https://github.com/romkatv/powerlevel10k
[Waybar]: https://github.com/Alexays/Waybar
[Rofi]: https://github.com/davatorium/rofi
[Btop]: https://github.com/aristocratos/btop
[nemo]: https://github.com/linuxmint/nemo/
[zsh]: https://ohmyz.sh/
[Swaylock-effects]: https://github.com/mortie/swaylock-effects
[Hyprlock]: https://github.com/hyprwm/hyprlock
[audacious]: https://audacious-media-player.org/
[mpv]: https://github.com/mpv-player/mpv
[Neovim]: https://github.com/neovim/neovim
[grimblast]: https://github.com/hyprwm/contrib
[imv]: https://sr.ht/~exec64/imv/
[swaync]: https://github.com/ErikReider/SwayNotificationCenter
[Maple Mono]: https://github.com/subframe7536/maple-font
[NetworkManager]: https://wiki.gnome.org/Projects/NetworkManager
[network-manager-applet]: https://gitlab.gnome.org/GNOME/network-manager-applet/
[wl-clip-persist]: https://github.com/Linus789/wl-clip-persist
[wf-recorder]: https://github.com/ammen99/wf-recorder
[hyprpicker]: https://github.com/hyprwm/hyprpicker
[Gruvbox]: https://github.com/morhetz/gruvbox
[Papirus-Dark]: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
[Bibata-Modern-Ice]: https://www.gnome-look.org/p/1197198
[Colloid gtk theme]: https://github.com/vinceliuice/Colloid-gtk-theme
[OBS]: https://obsproject.com/
[superfile]: https://github.com/yorukot/superfile
