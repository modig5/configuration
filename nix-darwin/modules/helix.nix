{ ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "custom";

      editor = {
        line-number = "relative";
        auto-completion = false;
        bufferline = "multiple";
        color-modes = true;
        cursorline = true;
        idle-timeout = 0;
        text-width = 100;
        file-picker.hidden = false;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline.mode = {
          insert = "INSERT";
          normal = "NORMAL";
          select = "SELECT";
        };

        indent-guides = {
          character = "▏";
          render = true;
        };

        whitespace = {
          characters.tab = "→";
          render.tab = "all";
        };
      };

      keys.normal.D = "extend_to_line_end";
      keys.select.D = "extend_to_line_end";
    };

    themes.custom = {
      inherits = "gruvbox_dark_hard";
      "comment" = { fg = "gray"; };
      "variable.builtin" = { };
    };

    languages = {
      language = [
        {
          name = "python";
          language-servers = [ "pyright" ];
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "c";
          language-servers = [ "clangd" ];
        }
        {
          name = "nix";
          language-servers = [ "nixd" ];
          formatter.command = "nixfmt";
        }
        {
          name = "java";
          language-servers = [ "jdtls" ];
          formatter.command = "google-java-format";
          formatter.args = [ "-" ];
        }
      ];

      language-server = {
        rust-analyzer.command = "rust-analyzer";
        clangd.command = "clangd";
        nixd.command = "nixd";
        jdtls.command = "jdtls";
      };
    };
  };
}
