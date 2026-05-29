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
      autoindent = true;

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
          latex
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

      # Indentation automatique intelligente
      guess-indent.enable = true;

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
          # LSP pour LaTeX
          texlab.enable = true;
        };
      };

      # Formattage automatique à la sauvegarde
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters_by_ft = {
            python = [ "black" ];
            rust = [ "rustfmt" ];
            nix = [ "nixfmt" ];
            lua = [ "stylua" ];
            tex = [ "latexindent" ];
            "_" = [ "trim_whitespace" ];
          };
        };
      };

      # Autocomplétion
      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      # Snippets
      luasnip.enable = true;
      cmp_luasnip.enable = true;

      # Débogueur (DAP)
      dap = {
        enable = true;
        extensions = {
          # DAP pour Python
          dap-python = {
            enable = true;
            adapterPythonPath = "python3";
          };
          # UI pour le débogueur
          dap-ui.enable = true;
          # Indicateurs visuels dans la gouttière
          dap-virtual-text.enable = true;
        };
      };

      # LaTeX dans Neovim
      vimtex = {
        enable = true;
        texlivePackage = pkgs.texlive.combined.scheme-medium;
        settings = {
          view_method = "zathura";
          compiler_method = "latexmk";
        };
      };

      # Terminal intégré
      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          size = 15;
          open_mapping = "[[<C-t>]]";
        };
      };

      # Git / aide aux raccourcis / parenthèses auto
      gitsigns.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
    };

    # Paquets supplémentaires nécessaires
    extraPackages = with pkgs; [
      # Formatteurs Python
      black
      ruff
      # Formatteur Nix
      nixfmt-rfc-style
      # Formatteur Lua
      stylua
      # LaTeX
      texlive.combined.scheme-medium
      zathura
      # DAP pour Rust (via codelldb)
      lldb
    ];

    # Raccourcis clavier
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
      # LSP
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
        key = "gr";
        action.__raw = "vim.lsp.buf.references";
        options.desc = "Références LSP";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action.__raw = "vim.lsp.buf.rename";
        options.desc = "Renommer (LSP)";
      }
      {
        mode = "n";
        key = "K";
        action.__raw = "vim.lsp.buf.hover";
        options.desc = "Documentation LSP";
      }
      {
        mode = "n";
        key = "[d";
        action.__raw = "vim.diagnostic.goto_prev";
        options.desc = "Diagnostic précédent";
      }
      {
        mode = "n";
        key = "]d";
        action.__raw = "vim.diagnostic.goto_next";
        options.desc = "Diagnostic suivant";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "<cmd>Telescope diagnostics<CR>";
        options.desc = "Liste des diagnostics";
      }
      # DAP (débogueur)
      {
        mode = "n";
        key = "<leader>db";
        action.__raw = "require('dap').toggle_breakpoint";
        options.desc = "Toggle breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action.__raw = "require('dap').continue";
        options.desc = "Débogueur : continuer";
      }
      {
        mode = "n";
        key = "<leader>do";
        action.__raw = "require('dap').step_over";
        options.desc = "Débogueur : step over";
      }
      {
        mode = "n";
        key = "<leader>di";
        action.__raw = "require('dap').step_into";
        options.desc = "Débogueur : step into";
      }
      {
        mode = "n";
        key = "<leader>du";
        action.__raw = "require('dapui').toggle";
        options.desc = "Toggle UI débogueur";
      }
      # LaTeX
      {
        mode = "n";
        key = "<leader>ll";
        action = "<cmd>VimtexCompile<CR>";
        options.desc = "Compiler LaTeX";
      }
      {
        mode = "n";
        key = "<leader>lv";
        action = "<cmd>VimtexView<CR>";
        options.desc = "Voir le PDF LaTeX";
      }
      {
        mode = "n";
        key = "<leader>le";
        action = "<cmd>VimtexErrors<CR>";
        options.desc = "Erreurs LaTeX";
      }
    ];

    # DAP Rust via codelldb + highlight après yank
    extraConfigLua = ''
      -- Highlight après yank
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          vim.highlight.on_yank({ timeout = 150 })
        end,
      })

      -- DAP pour Rust (codelldb)
      local dap = require('dap')
      dap.adapters.codelldb = {
        type = 'server',
        port = 13000,
        executable = {
          command = 'codelldb',
          args = { '--port', '13000' },
        },
      }
      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Chemin vers executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = vim.fn.getcwd(),
          stopOnEntry = false,
        },
      }

      -- Ouvrir/fermer l'UI DAP automatiquement
      local dapui = require('dapui')
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    '';
  };
}
