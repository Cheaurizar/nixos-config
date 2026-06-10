{ pkgs, ... }:
{
  home.packages = with pkgs; [ stirling-pdf-desktop ];
}
