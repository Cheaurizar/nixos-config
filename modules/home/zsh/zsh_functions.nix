{ config, ... }:
{
  home.file.".config/zsh/functions/gitctx.zsh".source = ./gitctx.zsh;
  home.file.".config/zsh/functions/mkcd.zsh".source = ./mkcd.zsh;
  programs.zsh.initContent = ''
    source ${config.home.homeDirectory}/.config/zsh/functions/gitctx.zsh
    source ${config.home.homeDirectory}/.config/zsh/functions/mkcd.zsh
  '';
}
