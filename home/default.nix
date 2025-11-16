{ config, pkgs, lib, primaryUser, self, ... }:
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


    # TODO: absolute paths cause impure execution
    
    # Create symlink from dotfiles directory to home directory
    # When source points to a path outside the Nix store, home-manager creates a symlink
    # Files
    file.".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "/Users/${primaryUser}/projects/dev_config/dotfiles/.gitconfig";
    file.".terraformrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/${primaryUser}/projects/dev_config/dotfiles/.terraformrc";
    file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/Users/${primaryUser}/projects/dev_config/dotfiles/.zshrc-zinit.zshrc";
    # Directories (symlink works the same way for folders)

    file.".config/ohmyposh".source = config.lib.file.mkOutOfStoreSymlink "/Users/${primaryUser}/projects/dev_config/dotfiles/.config/ohmyposh";
    file.".zprezto-custom".source = config.lib.file.mkOutOfStoreSymlink "/Users/${primaryUser}/projects/dev_config/.zprezto-custom";

    # VSCode prompts - symlink from repo to VSCode config directory
    #file."Library/Application Support/Code/User/prompts".source = config.lib.file.mkOutOfStoreSymlink "../files/vscode/prompts";

    #file."Library/Application Support/Code/User/prompts".source = ./files/vscode/prompts;
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
