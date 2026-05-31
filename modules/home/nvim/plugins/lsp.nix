{ ... }:

{
  programs.nixvim.plugins = {
    # Language server protocol
    lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true; # Nix
        lua_ls.enable = true; # Lua
        pyright.enable = true; # Python
        rust_analyzer = {
          # Rust
          enable = true;
          installCargo = true;
          installRustc = true;
        };
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
  };
}
