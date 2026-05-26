# modules/home/nvim.nix
{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    colorschemes.catppuccin.enable = true;  # ou tokyonight, gruvbox, etc.

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
    };

    globals.mapleader = " ";

    plugins = {
      lualine.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
        };
      };
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      web-devicons.enable = true;
      gitsigns.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;

      # LSP
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;          # LSP Nix
          # lua_ls.enable = true;
          # rust_analyzer = { enable = true; installCargo = true; installRustc = true; };
          # ts_ls.enable = true;
          # pyright.enable = true;
        };
        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gr" = "references";
            "K" = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
        };
      };

      # Complétion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
    };

    keymaps = [
      { mode = "n"; key = "<leader>w"; action = ":w<CR>"; }
      { mode = "n"; key = "<leader>q"; action = ":q<CR>"; }
      { mode = "n"; key = "<Esc>"; action = ":noh<CR>"; }
    ];
  };
}
