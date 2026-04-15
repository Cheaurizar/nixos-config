{ pkgs, ... }:
{
  home.packages = with pkgs; [ snx-rs ];
}
