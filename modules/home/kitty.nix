{ host, ... }:
{
  programs.kitty = {
    enable = true;

    themeFile = "gruvbox-dark-hard";

    font = {
      name = "Maple Mono";
      size = if (host == "laptop") then 10 else 16;
    };

    extraConfig = ''
      font_features MapleMono-Regular +ss01 +ss02 +ss04
      font_features MapleMono-Bold +ss01 +ss02 +ss04
      font_features MapleMono-Italic +ss01 +ss02 +ss04
      font_features MapleMono-Light +ss01 +ss02 +ss04
    '';

    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.66";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;
      window_padding_width = if (host == "laptop") then 5 else 10;

      ## Tabs
      #tab_title_template = "{index}";
      #active_tab_font_style = "normal";
      #inactive_tab_font_style = "normal";
      #tab_bar_style = "powerline";
      #tab_powerline_style = "angled";
      #active_tab_foreground = "#FBF1C7";
      #active_tab_background = "#7C6F64";
      #inactive_tab_foreground = "#FBF1C7";
      #inactive_tab_background = "#3C3836";
      ## name: Cyberpunk (V1xEr3bus)
      # ╔════════════════════╗
      # ║     Basic Colors   ║
      # ╚════════════════════╝
      foreground = "#FF003C";
      background = "#000000";
      selection_foreground = "none";
      selection_background = "#000000";
      
      # ╔══════════════════════╗
      # ║    Cursor & URL      ║
      # ╚══════════════════════╝
      cursor = "#00F0FF";
      cursor_text_color = "background";
      url_color = "#FCEE09";
      
      # ╔═════════════════════════════╗
      # ║   Window & Bell Borders     ║
      # ╚═════════════════════════════╝
      active_border_color = "#FF003C";
      inactive_border_color = "#0e0e0e";
      bell_border_color = "#FF003C";
      visual_bell_color = "none";
      
      # ╔═════════════════════╗
      # ║       Tab Bar       ║
      # ╚═════════════════════╝
      active_tab_foreground = "#060606";
      active_tab_background = "#FF003C";
      inactive_tab_foreground = "#FF003C";
      inactive_tab_background = "#060606";
      tab_bar_background = "#060606";
      tab_bar_margin_color = "#060606";

      # ╔═════════════════════╗
      # ║      ANSI Colors    ║
      # ╚═════════════════════╝
      # black / brblack
      color0  = "#060606";
      color8  = "#1a1a1a";

      # red / brred  (Main)
      color1  = "#FF003C";
      color9  = "#FF335F";

      # green / brgreen
      color2  = "#00FF9C";
      color10 = "#36FFB9";

      # yellow / bryellow  (Accent)
      color3  = "#FCEE09";
      color11 = "#FDE93F";

      # blue / brblue
      color4  = "#0A84FF";
      color12 = "#4AA3FF";

      # magenta / brmagenta
      color5  = "#D57BFF";
      color13 = "#C592FF";

      # cyan / brcyan (Secondary)
      color6  = "#00F0FF";
      color14 = "#5AF7FF";
      
      # white / brwhite
      color7  = "#EEFFFF";
      color15 = "#FFFFFF";
    };

    keybindings = {
      ## Tabs
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";

      ## Unbind
      "ctrl+shift+left" = "no_op";
      "ctrl+shift+right" = "no_op";
    };
  };
}
