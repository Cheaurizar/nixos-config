{ config, ... }:

{
  programs.nixvim = {
    # Thème
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
        settings.view.width = 35;
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
  };
}
