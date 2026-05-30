{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp.servers.texlab.enable = true;

      vimtex = {
        enable = true;
        texlivePackage = pkgs.texlive.combined.scheme-medium;
        settings = {
          view_method = "zathura";
          compiler_method = "latexmk";
        };
      };
    };

    keymaps = [
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
  };
}
