{ pkgs, config, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };

    # =========================================================
    # NOYAU LINUX (Kernel)
    # =========================================================

    # Utilise la dernière version stable du noyau Linux.
    # Alternatives possibles :
    #   pkgs.linuxPackages        → version LTS (plus stable, recommandé pour les serveurs)
    #   pkgs.linuxPackages_latest → dernière version (meilleure compatibilité matérielle)
    #   pkgs.linuxPackages_zen    → version optimisée pour le desktop
    kernelPackages = pkgs.linuxPackages_latest;


    # =========================================================
    # MODULES CHARGÉS AU DÉMARRAGE
    # =========================================================
    kernelModules = [
      # Permet de partager la connexion internet depuis un téléphone Android
      # branché en USB (USB tethering). Tu peux supprimer ces deux lignes
      # si tu n'utilises jamais cette fonctionnalité.
      "rndis_host"
      "cdc_ether"
    ];

    # =========================================================
    # SYSTÈMES DE FICHIERS SUPPORTÉS
    # =========================================================
    supportedFilesystems = [
      # Permet de lire/écrire sur des partitions Windows (NTFS).
      # Très utile si tu as un dual-boot Windows/NixOS comme c'est ton cas.
      # Tu peux retirer "ntfs" si tu ne veux jamais accéder à ta partition Windows.
      "ntfs"
    ];
  };

  # =========================================================
  # FIRMWARE ET BASCULEMENT USB (pour la carte WiFi Ugreen)
  # =========================================================

  # Active les firmwares redistribuables (fichiers binaires nécessaires
  # à certains matériels comme les cartes WiFi Realtek).
  # Sans ça, le driver WiFi peut se charger mais ne pas fonctionner.
  hardware.enableRedistributableFirmware = true;

  # usb-modeswitch fait basculer la carte WiFi de son mode "CD-ROM virtuel"
  # vers son mode WiFi réel au branchement. Sans ça, Linux voit la carte
  # comme un lecteur CD et non comme une carte réseau.
  # usb-modeswitch-data contient les règles pour des centaines d'adaptateurs USB.
  # Tu peux retirer ces deux lignes si tu changes de carte WiFi pour une
  # qui n'a pas ce problème de "CDROM Mode".
  services.udev.packages = [ pkgs.usb-modeswitch-data ];
  environment.systemPackages = with pkgs; [
    usb-modeswitch
    usb-modeswitch-data
  ];
}
