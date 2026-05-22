{ ... }:
{
  imports = [
    ./nixpkgs.nix # Sert pour setup NUR donc des packages en plus et aussi ajouter les packages perso qui sont dans le dossier package
    ./bootloader.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./nh.nix
    ./pipewire.nix # Sert a gérer tout ce qui est en lien avec le son de la config
    ./program.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./user.nix
    ./wayland.nix
    ./virtualization.nix
    ./qmk.nix
    ./flatpak.nix
  ];
}
