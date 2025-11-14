{ pkgs, lib, primaryUser, ... }:
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
    # Files
    file.".gitconfig".source = "/Users/${primaryUser}/projects/dev_config/dotfiles/.gitconfig";
    file.".terraformrc".source = "/Users/${primaryUser}/projects/dev_config/dotfiles/.terraformrc";
    file.".zshrc".source = "/Users/${primaryUser}/projects/dev_config/dotfiles/.zshrc-zinit";
    # Directories (symlink works the same way for folders)

    file.".config/ohmyposh".source = "/Users/${primaryUser}/projects/dev_config/dotfiles/.config/ohmyposh";
    file.".zprezto-custom".source = "/Users/${primaryUser}/projects/dev_config/.zprezto-custom";
  };
  
  # Copy files from dotfiles directory only if they don't exist
  home.activation.copyDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Helper function to copy file if it doesn't exist
    copy_if_not_exists() {
      local source="$1"
      local dest="$2"
      if [ ! -e "$dest" ] && [ -f "$source" ]; then
        echo "Copying $source to $dest"
        cp "$source" "$dest"
      elif [ ! -f "$source" ]; then
        echo "Warning: Source file $source does not exist, skipping..."
      elif [ -e "$dest" ]; then
        echo "File $dest already exists, skipping..."
      fi
    }

    # Copy onetime dotfiles
    copy_if_not_exists "/Users/${primaryUser}/projects/dev_config/dotfiles/.zshrc-custom-zinit-home.zshrc" "$HOME/.zshrc-custom-zinit.zshrc"
    copy_if_not_exists "/Users/${primaryUser}/projects/dev_config/dotfiles/.gitconfig-custom" "$HOME/.gitconfig-custom"
  '';
}
