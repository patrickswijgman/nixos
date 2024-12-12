{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  home-manager.users.patrick = {
    wayland.windowManager.sway = {
      enable = true;
      systemd = {
        enable = true;
      };
      wrapperFeatures = {
        gtk = true;
      };
      config = rec {
        startup = [
          {
            # Restart kanshi after sway config reload to reload output configuration.
            command = "systemctl --user restart kanshi";
            always = true;
          }
        ];
        modifier = "Mod4";
        terminal = "alacritty";
        keybindings = mkOptionDefault {
          "${modifier}+Ctrl+l" = "exec swaylock";
          "${modifier}+Shift+s" = "exec flameshot gui";
          "${modifier}+Tab" = "workspace back_and_forth";
          "${modifier}+d" = "exec rofi -show run";
          "${modifier}+x" = "splitv";
          "${modifier}+v" = "splith";
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
            pointer_accel = "-0.4";
            scroll_factor = "1";
          };
        };
        bars = [
          {
            statusCommand = "i3status-rs config-default.toml";
            trayOutput = "none";
          }
        ];
      };
    };

    programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          theme = "plain";
          icons = "awesome4";
        };
      };
    };

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "alacritty -e";
    };

    programs.swaylock = {
      enable = true;
      settings = {
        color = "#000000";
      };
    };

    services.mako = {
      enable = true;
    };

    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 180;
          command = "${pkgs.swaylock}/bin/swaylock";
        }
      ];
    };

    services.kanshi = {
      enable = true;
      settings = [
        # Desktop
        {
          profile.outputs = [
            {
              criteria = "Iiyama North America PL2760Q 1154192101586";
              mode = "2560x1440@143.856Hz";
            }
          ];
        }
        # Laptop
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
              criteria = "Iiyama North America PL2760Q 1154192101586";
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
      ];
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
          showDesktopNotification = false;
          showHelp = false;
        };
      };
    };

    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk = {
        enable = true;
      };
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };

    home.packages = with pkgs; [
      xdg-utils
      wl-clipboard
      pamixer
      playerctl
      brightnessctl
    ];

    home.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
      NIXOS_OZONE_WL = "1";
    };
  };

  # Grant more (within certain boundaries) privileges to programs.
  security.polkit.enable = true;

  # Fix for swaylock to be able to detect a correct password.
  security.pam.services.swaylock = { };

  # Enable OpenGL for hardware acceleration.
  hardware.graphics.enable = true;

  # Enable database for GNOME settings.
  programs.dconf.enable = true;

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
}
