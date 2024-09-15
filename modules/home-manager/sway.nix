{
  config,
  pkgs,
  lib,
  ...
}:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        { command = "mako"; }
        {
          command = "kanshi";
          always = true;
        }
        {
          # This ensures all user units started after the command (not those already running) set the variables
          command = "systemctl --user import-environment";
        }
      ];
      keybindings = lib.mkOptionDefault {
        "${modifier}+Ctrl+l" = "exec swaylock";
        "${modifier}+Print" = "exec grimshot copy active";
        "${modifier}+Shift+s" = "exec grimshot copy area";
        "${modifier}+Tab" = "workspace back_and_forth";
        "XF86AudioMute" = "pamixer -t";
        "XF86AudioRaiseVolume" = "pamixer -i 5";
        "XF86AudioLowerVolume" = "pamixer -d 5";
        "XF86AudioPlay" = "playerctl play-pause";
        "XF86AudioNext" = "playerctl next";
        "XF86AudioPrev" = "playerctl previous";
        "XF86MonBrightnessDown" = "brightnessctl set 10%-";
        "XF86MonBrightnessUp" = "brightnessctl set 10%+";
      };
      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.25";
          scroll_factor = "1";
        };
      };
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
    };
  };

  services.kanshi = {
    enable = true;
  };

  services.mako = {
    enable = true;
  };

  home.packages = with pkgs; [
    xdg-utils
    wl-clipboard
    pamixer
    playerctl
    brightnessctl
    sway-contrib.grimshot
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
}
