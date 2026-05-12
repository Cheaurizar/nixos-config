{ pkgs, config, ... }:
{
  boot = {

    # =========================================================
    # BOOTLOADER
    # C'est le programme qui démarre NixOS au lancement du PC.
    # systemd-boot est un bootloader simple intégré à NixOS.
    # =========================================================
    loader = {

      # Active le bootloader systemd-boot.
      # Si tu veux utiliser GRUB à la place, mets "false" ici
      # et ajoute : boot.loader.grub.enable = true;
      systemd-boot.enable = true;

      # Autorise NixOS à modifier les variables EFI de ta carte mère.
      # Nécessaire pour que le boot fonctionne correctement sur la plupart des PCs.
      # À mettre sur "false" uniquement si ta carte mère pose des problèmes avec ça.
      efi.canTouchEfiVariables = true;

      # Nombre maximum de générations NixOS gardées dans le menu de boot.
      # Chaque "sudo nixos-rebuild switch" crée une nouvelle génération.
      # Si tu mets une valeur plus grande, tu peux revenir plus loin en arrière.
      # Si tu mets une valeur plus petite (ex: 3), tu économises de l'espace disque.
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
