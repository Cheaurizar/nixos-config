{ pkgs, ... }:
let
  palette = {
    color_fgw = "#FFFFFF";
    color_fgb = "#000000";
    color_bg1 = "#3c3836";
    color_blue = "#0A84FF";
    color_green = "#00FF6C";
    color_red = "#CC0000";
    color_pink = "#FF0055";
    color_white = "#FFFFFF";
    color_cyan = "#0000AA";
  };

  defaultFg = "color_fgw";

  # Segments de gauche : affichés dans l'ordre, séparateurs pointant vers la droite
  leftSegments = [
    { bg = "color_red";   fg = "color_fgw"; modules = [ "directory" ]; }
    { bg = "color_green"; fg = "color_fgb"; modules = [ "cmd_duration" ]; }
    { bg = "color_blue";  fg = "color_fgw"; modules = [ "git_branch" "git_status" ]; }
  ];

  # Segments de droite : affichés dans l'ordre, séparateurs pointant vers la gauche
  rightSegments = [
    { bg = "color_pink"; fg = "color_fgw"; modules = [ "python" "container" ]; }
    { bg = "color_bg1";  fg = "color_fgw"; modules = [ "time" ]; }
  ];

  # Tous les segments réunis, pour que styleOfModule fonctionne quel que soit le côté
  segments = leftSegments ++ rightSegments;

  # Séparateurs powerline
  sepLeftFilled  = "";   # triangle plein pointant à droite (ouvre un segment à gauche)
  sepLeftEnd     = "";   # triangle plein pointant à droite (ferme un segment à gauche)
  sepRightStart  = "";   # triangle plein pointant à gauche (ouvre un segment à droite)
  sepRightEnd    = "";   # triangle plein pointant à gauche (ferme un segment à droite)

  neutral = "color_white";

  segFg = seg: if seg ? fg then seg.fg else defaultFg;
  styleOf = seg: "bg:${seg.bg} fg:${segFg seg}";

  segOf = m: builtins.head (builtins.filter (s: builtins.elem m s.modules) segments);
  styleOfModule = m: styleOf (segOf m);

  modulesStr = seg: builtins.concatStringsSep "" (map (m: "$" + m) seg.modules);

  # Segment gauche : triangle droite, contenu, triangle droite
  buildLeftSegment = seg:
    ''[${sepLeftFilled}](fg:${neutral} bg:${seg.bg})${modulesStr seg}[${sepLeftEnd}](fg:${seg.bg} bg:${neutral})'';

  # Segment droit : triangle gauche, contenu, triangle gauche
  buildRightSegment = seg:
    ''[${sepRightStart}](fg:${seg.bg} bg:${neutral})${modulesStr seg}[${sepRightEnd}](fg:${neutral} bg:${seg.bg})'';

  leftBody  = builtins.concatStringsSep "" (map buildLeftSegment  leftSegments);
  rightBody = builtins.concatStringsSep "" (map buildRightSegment rightSegments);

  # $fill étire un caractère sur toute la largeur dispo entre gauche et droite
  promptFormat =
    "[${sepLeftFilled}](fg:color_bg1 bg:${neutral})"
    + leftBody
    + "[${sepLeftFilled}](bg:none fg:${neutral})"
    + "$fill"
    + "[${sepRightEnd}](bg:none fg:${neutral})"
    + rightBody
    + "[${sepRightEnd}](fg:color_bg1 bg:${neutral})"
    + "$line_break"
    + "[${sepLeftFilled}](fg:${neutral})";
in
{
  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = promptFormat;
      palette = "gruvbox_dark";
      palettes.gruvbox_dark = palette;

      # Le module fill dessine la barre de liaison entre les deux côtés
      fill = {
        symbol = "─";
        style = "fg:${neutral}";
      };

      username = {
        show_always = true;
        style_user = styleOfModule "directory";
        style_root = styleOfModule "directory";
        format = "[ $user ]($style)";
      };

      directory = {
        style = styleOfModule "directory";
        format = "[ $path ]($style)";
        truncation_length = 7;
        truncation_symbol = "…/";
      };

      git_branch = {
        style = styleOfModule "git_branch";
        always_show_remote = false;
        symbol = " ";
        format = "[ $symbol $branch(:$remote_branch) ]($style)";
      };

      git_status = {
        style = styleOfModule "git_status";
        format = "[($all_status$ahead_behind) ]($style)";
      };

      container = {
        style = styleOfModule "container";
        format = "[$symbol \\[$name\\]]($style)";
      };

      python = {
        style = styleOfModule "python";
        format = "[(\\($virtualenv\\)) ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = styleOfModule "time";
        format = "[ $time ]($style)";
      };

      cmd_duration = {
        disabled = false;
        min_time = 0;
        show_milliseconds = true;
        style = styleOfModule "cmd_duration";
        format = "[ $duration ]($style)";
      };
    };
  };
}
