{ config, ... }:
{
  home.file.".config/zsh/functions/gitctx.zsh".source = ./gitctx.zsh;

  programs.zsh.initContent = ''
    source ${config.home.homeDirectory}/.config/zsh/functions/gitctx.zsh
  '';
}
