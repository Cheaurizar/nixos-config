{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "io.github.everestapi.Olympus" 
    ];
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = [
          "wayland"
          "!x11"
          "!fallback-x11"
        ];
      };
      "io.github.everestapi.Olympus" = {
        # Olympus a besoin d'accéder au dossier Steam pour trouver Celeste
        # et de pouvoir lancer des sous-processus (le jeu lui-même)
        Context = {
          filesystems = [
            "~/.steam"
            "~/.local/share/Steam"
            "xdg-data/Steam"
          ];
        };
      };
    };
  };
}
