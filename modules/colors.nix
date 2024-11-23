{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

let
  colors = {
    bg = "#181818";
    bg_light = "#292929";

    text = "#d6d6dd";
    text_dark = "#898989";

    pink = "#d898d8";
    purple = "#a390f0";
    light_blue = "#7dbeff";
    blue = "#52a7f6";
    green = "#afcb85";
    cyan = "#78d0bd";
    orange = "#efb080";
    yellow = "#e5c995";
    red = "#CC7C8A";

    error_bg = "#4d2a2c";
    error_text = "#EB5F6A";

    warning_bg = "#4e321b";
    warning_text = "#EE7F25";
  };
in
{
  options = {
    colors = mkOption {
      type = types.attrsOf types.str;
      default = colors;
      description = "Color palette to use in Home Manager modules.";
    };
  };

  config = {
    colors = colors;
  };
}
