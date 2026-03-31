{ host, ... }:
let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
    programs.waybar.settings.mainBar = with custom; {
        position = "top";
        layer = "top";
        height = 28;
        spacing = 10;
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        modules-left = [
            "clock"
            "tray"
            "hyprland/language"
            "hyprland/window"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
            "pulseaudio"
            "battery"
            "custom/notification"
        ];
    clock = {
      calendar = {
        format = {
          today = "<span color='#98971A'><b>{}</b></span>";
        };
      };
      format = "{:%H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%d/%m}";
    };

    "hyprland/workspaces" = {
        "font" = "noto-sans-cjk";
        "disable-scroll" = false;
        "all-outputs" = true;
        "warp-on-scroll" = false;
        "format" = "{icon}";
        "format-icons" = {
            "1" = "I";
            "2" = "II";
            "3" = "III";
            "4" = "IV";
            "5" = "V";
            "6" = "VI";
            "7" = "VII";
            "8" = "VIII";
            "9" = "IX";
        };
        "persistent-workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
        };
    };

    "hyprland/window" = {
        "format" = "{class}:{title}";
        "rewrite" = {
            "^brave-browser:.*$" = " ";
            "^kitty:(.*)$"=" ";
            "^vesktop:.*$" = " ";
        };
    "separate-outputs" = true;
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "  {icon} {format_source}";
        format-muted = "  {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
            headphone = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
        };
        scroll-step = 2;
        on-click = "pavucontrol";
    };
    battery = {
        format = "{icon} {capacity}%";
        format-icons = [
            " "
            " "
            " "
            " "
            " "
        ];
        format-charging = "  {capacity}%"; # A modifier car ne s'affiche pas correctemetn
        format-full = "󰂄 {capacity}%";
        format-warning = " {capacity}%";
        interval = 5;
        states = {
            warning = 25;
            critical = 5;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "hyprland/language" = {
      tooltip = true;
      tooltip-format = "Keyboard layout";
      format = "<span foreground='#FABD2F'></span> {}";
      format-fr = "FR";
      format-en = "US";
      on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
    };
    "custom/notification" = {
      tooltip = false;
      tooltip-format = "Notifications";
      format = "{icon}";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };
}
