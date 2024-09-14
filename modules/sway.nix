{
  config,
  pkgs,
  lib,
  ...
}:

{
  # https://home-manager-options.extranix.com/?query=wayland.windowManager.sway&release=master
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

  # https://home-manager-options.extranix.com/?query=swaylock&release=master
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
    };
  };

  # https://home-manager-options.extranix.com/?query=kanshi&release=master
  services.kanshi = {
    enable = true;
  };

  # https://home-manager-options.extranix.com/?query=mako&release=master
  services.mako = {
    enable = true;
  };

  home.packages = with pkgs; [
    wl-clipboard
    pamixer
    playerctl
    brightnessctl
    sway-contrib.grimshot
  ];
}
