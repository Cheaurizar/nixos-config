{ pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {

    # ─── Monitors ────────────────────────────────────────────────────────────
    # DP-3 (AOC 24G2W1G4) → écran principal, physiquement à GAUCHE
    # DP-1 (TV DTV)       → écran secondaire, physiquement à DROITE
    #
    # Syntaxe : "NOM, RÉSOLUTIONxHAUTEUR@HZ, POSITIONxY, SCALE"
    monitor = [
      "DP-3, 1920x1080@144, 0x0, 1"       # AOC — principal, gauche, 144Hz
      "DP-1, 1360x768@60,   1920x0, 1"    # TV  — secondaire, droite, 60Hz
    ];

    # ─── Workspaces ──────────────────────────────────────────────────────────
    # Workspaces 1-5 sur l'écran principal (AOC, DP-3)
    # Workspaces 6-10 sur l'écran secondaire (TV, DP-1)
    workspace = [
      "1,  monitor:DP-3, default:true"
      "2,  monitor:DP-3"
      "3,  monitor:DP-3"
      "4,  monitor:DP-3"
      "5,  monitor:DP-3"

      "6,  monitor:DP-1, default:true"
      "7,  monitor:DP-1"
      "8,  monitor:DP-1"
      "9,  monitor:DP-1"
      "10, monitor:DP-1"

      # Règles visuelles (reprises depuis windowrules.nix, on les garde ici aussi)
      "w[t1],  gapsout:10, gapsin:0"
      "w[tg1], gapsout:10, gapsin:0"
      "f[1],   gapsout:10, gapsin:0"
    ];

  };

  home.packages = with pkgs; [ nwg-displays ];
}
