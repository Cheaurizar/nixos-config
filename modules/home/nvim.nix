{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  # Configuration Nixvim basique pour Neovim.
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

      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      signcolumn = "yes";
      scrolloff = 8;
      updatetime = 250;
    };

    # Thème + barre de statut
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;

      # Explorateur de fichiers
      nvim-tree = {
        enable = true;
        view.width = 35;
      };

      # Recherche de fichiers / grep
      telescope.enable = true;

      # Syntax highlighting avancé
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          nix
          lua
          python
          rust
          bash
          json
          yaml
          toml
          markdown
        ];
      };

      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
          };
          scope = {
            enabled = true;
            show_start = true;
            show_end = true;
          };
        };
      };

      # Language server protocol
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };

      # Autocomplétion basique
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      # Git / aide aux raccourcis / parenthèses auto
      gitsigns.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
    };

    # Raccourcis clavier simples
    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Sauvegarder";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quitter";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Ouvrir/fermer l'explorateur";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Chercher un fichier";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Chercher dans le projet";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action.__raw = "vim.lsp.buf.code_action";
        options.desc = "Code action LSP";
      }
      {
        mode = "n";
        key = "gd";
        action.__raw = "vim.lsp.buf.definition";
        options.desc = "Aller à la définition";
      }
      {
        mode = "n";
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Documentation LSP";
      }
    ];

    # Petit confort : highlight après yank
    extraConfigLua = ''
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          vim.highlight.on_yank({ timeout = 150 })
        end,
      })
    '';
  };
}
