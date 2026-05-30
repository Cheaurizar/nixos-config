{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./plugins
    ./keymaps.nix
    ./extra.nix
  ];

  programs.nixvim = {
    enable = true;

    # Alias pratiques
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # Leader key
    globals.mapleader = " ";
    globals.maplocalleader = " ";

    # Options Neovim classiques
    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      clipboard = "unnamedplus";

      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;
      autoindent = true;

      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      signcolumn = "yes";
      scrolloff = 8;
      updatetime = 250;
    };
  };
}
