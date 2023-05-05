{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jsm";
  home.homeDirectory = "/home/jsm";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.bat
    pkgs.ripgrep
    pkgs.cargo
    pkgs.exa
    pkgs.tree
    pkgs.tldr
    pkgs.zip
    pkgs.docker
    pkgs.docker-compose
    pkgs.awscli2
    # pkgs.zoxide

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "code";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    enableZshIntegration = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    initExtra = ''
    wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit status >/dev/null || wsl.exe -d wsl-vpnkit --cd /app service wsl-vpnkit start
    source .authenticate/authenticate.sh
    '';

    oh-my-zsh = {
      enable = true;
      plugins = with pkgs; [
        "git"
        # "zsh-autosuggestions"
        # "zsh-syntax-highlighting"
        # "zsh-z"
        # "zsh-history-substring-search"
        # "powerlevel10k"
        # "powerlevel10k-config"
       ];
      theme = "";
    };

    shellAliases = {
      l="exa --all --long --icons --color=auto --no-permissions --octal-permissions";
    };
  };


  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

    };
  };


  programs.git = {
    enable = true;
    userName = "James Menzies";
    userEmail = "james@menzies.io";
    signing = {
      signByDefault = true;
      key = "997831B9742AA61A";
    };
    extraConfig = {
      core.autocrlf = "input";
      push.autoSetupRemote = true;
      submodule.recurse = true;
      init.defaultBranch = "main";
      color.ui = true;
    };
  };

  programs.ssh ={
    enable = true;
  };
}