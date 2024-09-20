{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        {
          command = "mako";
        }
        {
          command = "makoctl reload";
          always = true;
        }
        {
          command = "systemctl --user restart kanshi";
          always = true;
        }
        {
          # This ensures all user units started after the command (not those already running) set the variables
          command = "systemctl --user import-environment";
        }
      ];
      keybindings = mkOptionDefault {
        "${modifier}+Ctrl+l" = "exec swaylock";
        "${modifier}+Print" = "exec grimshot copy active";
        "${modifier}+Shift+s" = "exec grimshot copy area";
        "${modifier}+Tab" = "workspace back_and_forth";
        "XF86AudioMute" = "exec pamixer -t";
        "XF86AudioRaiseVolume" = "exec pamixer -i 5";
        "XF86AudioLowerVolume" = "exec pamixer -d 5";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
      };
      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.5";
          scroll_factor = "1";
        };
      };
      bars = [
        { statusCommand = "i3status-rs ~/.config/i3status-rust/config-default.toml"; }
      ];
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        theme = "native";
        icons = "awesome4";
        # https://docs.rs/i3status-rs/latest/i3status_rs/blocks/index.html#modules
        blocks = [
          { block = "disk_space"; }
          { block = "memory"; }
          { block = "cpu"; }
          { block = "music"; }
          {
            block = "sound";
            format = " $icon {$volume.eng(w:2)|} $output_description ";
          }
          {
            block = "net";
            format = " $icon{ $signal_strength $ssid | $ip }";
          }
          { block = "backlight"; }
          { block = "battery"; }
          { block = "time"; }
        ];
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
    settings = [
      {
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
      {
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL U2720Q 87RFX83";
            scale = 1.5;
          }
        ];
      }
      {
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Iiyama North America PL2760Q 1154192101586";
          }
        ];
      }
    ];
  };

  services.mako = {
    enable = true;
    anchor = "top-center";
    margin = "32";
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
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
    NIXOS_OZONE_WL = "1";
  };
}
