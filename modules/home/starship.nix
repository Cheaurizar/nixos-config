{ pkgs, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format = ''[](bg:color_white fg:color_bg1)[](bg:color_red fg:color_white)$directory[](bg:color_white fg:color_red)[](bg:color_green fg:color_white)$cmd_duration[](fg:color_green bg:color_white)[](bg:color_blue fg:color_white)$git_branch$git_status[](fg:color_blue bg:color_white)[](fg:color_white bg:color_pink)$python$rust$container[](fg:color_pink bg:color_white)[](fg:color_white bg:color_bg1)$time[](fg:color_bg1 bg:color_white)[](fg:color_white)$line_break[](fg:color_bg1 bg:color_white)[](fg:color_white) '';

    palette = "gruvbox_dark";

    palettes.gruvbox_dark = {
      color_fg0 = "#fbf1c7";
      color_bg1 = "#3c3836";
      color_blue = "#0000AA";
      color_green = "#008800";
      color_red = "#CC0000";
      color_pink = "#FF0055";
      color_white = "#FFFFFF";
      color_cyan = "0000AA";
    };

    username = {
      show_always = true;
      style_user = "bg:color_red fg:color_fg0";
      style_root = "bg:color_red fg:color_fg0";
      format = "[ $user ]($style)";
    };

    directory = {
      style = "fg:color_fg0 bg:color_red";
      format = "[ $path ]($style)";
      truncation_length = 7;
      truncation_symbol = "…/";
    };

    git_branch = {
      style = "bg:color_blue";
      always_show_remote = true;
      format = "[[ $branch | ($remote_branch) | ](fg:color_fg0 bg:color_blue)]($style)";
    };

    git_status = {
      style = "bg:color_blue";
      format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_blue)]($style)";
    };

    container = {
      style = "bg:color_pink";
      format = "[$symbol \[$name\]]($style)";
    };

    time = {
      disabled = false;
      time_format = "%R";
      style = "bg:color_bg1";
      format = "[[ $time ](fg:color_fg0 bg:color_bg1)]($style)";
    };

    python = {
      style ="bg:color_pink";
      format = "[[(\($virtualenv\)) ]( bg:color_pink)]($style)";
    };

    rust = {
      style ="bg:color_pink";
      format = "[$version]($style)";  
    };

    cmd_duration = {
      disabled = false;
      min_time = 0;
      show_milliseconds = true;
      style = "bg:color_green";
      format = "[ $duration ]($style)";
    };


  };
};
}
