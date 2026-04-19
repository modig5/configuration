{ pkgs, ... }: {
  system.primaryUser = "victormodig";
  nix.enable = false;

  users.users.victormodig = {
    name = "victormodig";
    home = "/Users/victormodig";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    ripgrep
    jq
    helix
    nerd-fonts.jetbrains-mono
    zoxide
    yazi
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "ghostty"
    ];
  };

  programs.zsh.enable = true;

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
  };

  home-manager.backupFileExtension = "backup";

  home-manager.users.victormodig = { ... }: {
    home.stateVersion = "24.05";

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;

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

        set -g __fish_git_prompt_showdirtystate yes
        set -g __fish_git_prompt_showupstream auto
        set -g __fish_git_prompt_char_upstream_equal ""
        set -g __fish_git_prompt_char_upstream_ahead "↑"
        set -g __fish_git_prompt_char_upstream_behind "↓"
        set -g __fish_git_prompt_color_branch yellow
        set -g __fish_git_prompt_color_dirtystate red
        set -g __fish_git_prompt_color_upstream_ahead ffb90f
        set -g __fish_git_prompt_color_upstream_behind blue

        set -g fish_pager_color_completion normal
        set -g fish_pager_color_description 555
        set -g fish_pager_color_prefix cyan
        set -g fish_pager_color_progress cyan

        if test -e ~/.extra.fish
          source ~/.extra.fish
        end
      '';
    };

    home.sessionVariables = {
      SHELL = "${pkgs.fish}/bin/fish";
    };

    programs.tmux = {
      enable = true;
      mouse = true;
      baseIndex = 1;
      prefix = "C-Space";
      historyLimit = 5000;
      keyMode = "vi";
      extraConfig = ''
        unbind r
        bind r source-file ~/.tmux.conf
        unbind C-b
        bind-key C-Space send-prefix
        bind g run-shell "~/.config/scripts/open-github.sh"
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R
        set -g status-position bottom
        set -g status-bg colour234
        set -g status-fg colour137
        set -g status-left ""
        set -g status-right '#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
        set -g status-right-length 50
        set -g status-left-length 20
        setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
        setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
      '';
    };

    home.file."Library/Application Support/com.mitchellh.ghostty/config".text = ''
      theme = Gruvbox Dark
      font-family = JetBrainsMono Nerd Font
      font-size = 20
      gtk-titlebar = false
      confirm-close-surface = false
      window-save-state = always
      macos-titlebar-style = hidden
      window-padding-x = 8
      window-padding-y = 8
      mouse-hide-while-typing = true
      quit-after-last-window-closed = true
      keybind = ctrl+shift+w=close_surface
      keybind = ctrl+t=new_tab
      keybind = ctrl+tab=next_tab
      keybind = ctrl+shift+n=new_window
      keybind = ctrl+shift+o=ignore
    '';
  };

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
