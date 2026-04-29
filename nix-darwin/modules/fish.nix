{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellInit = ''
      fish_add_path $HOME/.local/bin
    '';

    shellAbbrs = {
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gs = "git status";
      gd = "git diff";
      ll = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
    };

    functions = {
      fish_greeting = {
        body = "";
      };

      y = {
        body = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          command yazi $argv --cwd-file="$tmp"
          if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };

      ssource = {
        description = "Re-source fish config, useful when iterating";
        body = ''
          source ~/.config/fish/config.fish
          if test -e ~/.extra.fish
            source ~/.extra.fish
          end
        '';
      };

      fish_prompt = {
        body = ''
          set -l last_status $status
          set -l git_branch (git branch --show-current 2>/dev/null)

          set_color blue
          echo -n (prompt_pwd)
          set_color normal

          if test -n "$git_branch"
            echo -n " on "
            set_color magenta
            echo -n " $git_branch"
            if not git diff --quiet 2>/dev/null
              set_color yellow
              echo -n " ✗"
            else
              set_color green
              echo -n " ✓"
            end
            set_color normal
          end

          if test $last_status -ne 0
            set_color red
          else
            set_color green
          end
          echo -n " ❯ "
          set_color normal
        '';
      };
    };

    interactiveShellInit = ''
      set -g fish_color_autosuggestion 555
      set -g fish_color_command 5f87d7
      set -g fish_color_comment 808080
      set -g fish_color_cwd 87af5f
      set -g fish_color_cwd_root 5f0000
      set -g fish_color_error 870000 --bold
      set -g fish_color_escape af5f5f
      set -g fish_color_history_current 87afd7
      set -g fish_color_host 5f87af
      set -g fish_color_match d7d7d7 --background=303030
      set -g fish_color_normal normal
      set -g fish_color_operator d7d7d7
      set -g fish_color_param 5f87af
      set -g fish_color_quote d7af5f
      set -g fish_color_redirection normal
      set -g fish_color_search_match --background=purple
      set -g fish_color_status 5f0000
      set -g fish_color_user 5f875f
      set -g fish_color_valid_path --underline
      set -g fish_color_dimmed 555
      set -g fish_color_separator 999

      set -g fish_pager_color_completion normal
      set -g fish_pager_color_description 555
      set -g fish_pager_color_prefix cyan
      set -g fish_pager_color_progress cyan

      if test -e ~/.extra.fish
        source ~/.extra.fish
      end
    '';
  };
}
