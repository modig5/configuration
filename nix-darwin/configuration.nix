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

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
  };

  home-manager.backupFileExtension = "backup";

  home-manager.users.victormodig = { ... }: {
    imports = [
      ./modules/fish.nix
      ./modules/tmux.nix
      ./modules/ghostty.nix
    ];

    home.stateVersion = "24.05";

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    home.sessionVariables = {
      SHELL = "${pkgs.fish}/bin/fish";
    };
  };

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
