{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night";

      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };

      keys.normal = {
        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";
        "C-a" = "select_all";
        "C-r" = "redo";
        "C-d" = [
          "extend_to_line_bounds"
          "yank"
          "paste_after"
          "collapse_selection"
        ];
        "C-u" = "no_op";
        "A-r" = ":config-reload";
        "A-h" = "goto_previous_buffer";
        "A-l" = "goto_next_buffer";
        "A-q" = ":buffer-close";
        "A-tab" = "goto_last_accessed_file";
        "q" = "no_op";
        "Q" = "no_op";
        "x" = "select_line_below";
        "X" = "select_line_above";
        "Y" = [
          "extend_to_line_bounds"
          "yank"
        ];
        "D" = [
          "extend_to_line_bounds"
          "delete_selection"
        ];
        "esc" = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
    ];
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };
}
