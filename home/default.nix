{ primaryUser, ... }:
{
  imports = [
    #./packages.nix
    #./git.nix
    #./shell.nix
    #./mise.nix
  ];

  home = {
    username = primaryUser;
    stateVersion = "25.05";
    sessionVariables = {
      # shared environment variables
    };

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";

    # Create symlink from dotfiles directory to home directory
    # When source points to a path outside the Nix store, home-manager creates a symlink
    file.".gitconfig".source = "/Users/${primaryUser}/projects/dev_config/dotfiles/.gitconfig";
  };
}
