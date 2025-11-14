{
  pkgs,
  inputs,
  self,
  primaryUser,
  ...
}:
{
  imports = [
    ./homebrew.nix
    ./settings.nix
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  # nix config
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # disabled due to https://github.com/NixOS/nix/issues/7273
      # auto-optimise-store = true;
    };
    #enable = false; # using determinate installer
  };

  nixpkgs.config.allowUnfree = true;

  # homebrew installation manager
  nix-homebrew = {
    user = primaryUser;
    enable = true;
    autoMigrate = true;
  };

  # home-manager config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${primaryUser} = {
      imports = [
        ../home
      ];
    };
    extraSpecialArgs = {
      inherit inputs self primaryUser;
    };
  };

  # macOS-specific settings
  system.primaryUser = primaryUser;
  users.users.${primaryUser} = {
    home = "/Users/${primaryUser}";
    shell = pkgs.zsh;
  };
  environment = {
    systemPath = [
      "/opt/homebrew/bin"
    ];
    pathsToLink = [ "/Applications" ];
 etc = {
  "sudoers.d/10-nix-commands".text = let
    commands = [
      "/run/current-system/sw/bin/darwin-rebuild"
      "/run/current-system/sw/bin/nix*"
      "/run/current-system/sw/bin/ln"
      "/nix/store/*/activate"
      "/bin/launchctl"
      "/opt/homebrew/bin/brew"  # Add Homebrew if using casks
    ];
    commandsString = builtins.concatStringsSep ", " commands;
  in ''
    %admin ALL=(ALL:ALL) NOPASSWD: ${commandsString}
  '';
};
  };
}
