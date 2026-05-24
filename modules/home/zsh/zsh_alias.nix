{ ... }:
{
  programs.zsh = {
    shellAliases = {
      # Utils
      c = "clear";
      cd = "z";
      less = "bat";
      dsize = "du -hs";
      man = "batman";

      ls = "eza --icons --group-directories-first -1 -T -L 2 --no-user --long"; # EZA_ICON_SPACING=2
      la = "eza --icons --group-directories-first -1 -T -L 2 -a --no-user --long";
    };
  };
}
