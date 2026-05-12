{ ... }:
{
  programs.zsh = {
    shellAliases = {
      # Utils
      ls = "eza --icons -la";
      c = "clear";
      cd = "z";
      less = "bat";
      dsize = "du -hs";
      man = "batman";

      l = "eza --icons -a --group-directories-first -1 --no-user --long"; # EZA_ICON_SPACING=2
    };
  };
}
