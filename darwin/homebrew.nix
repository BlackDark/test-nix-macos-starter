{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    # homebrew is best for GUI apps
    # nixpkgs is best for CLI tools
    casks = [
      #"altserver"
      "amazon-workspaces"
      "android-platform-tools"
      #"beyond-compare"
      #"blobsaver"
      "citrix-workspace"
      "claude-code"
      "cursor"
      "cursor-cli"
      "discord"
      "drawio"
      #"dropbox"
      "firefly-iota-desktop"
      #"firefox"
      "font-cascadia-code"
      "font-cascadia-code-pl"
      "font-cascadia-mono"
      "font-cascadia-mono-pl"
      "font-fira-code"
      "font-fira-code-nerd-font"
      "font-hack-nerd-font"
      #"ftdi-vcp-driver"
      "gimp"
      "gpg-suite"
      "inkscape"
      "iterm2"
      # rosetta 2
      #"jabra-direct"

      #"keepassxc"
      #"latest"
      #"microsoft-auto-update"
      #"microsoft-edge"
      "microsoft-office"
      "microsoft-teams"
      "monitorcontrol"
      "onyx"
      "openvpn-connect"
      "orbstack"
      "orcaslicer"
      #"postman"
      #"rar"
      # "raspberry-pi-imager"
      "raycast"
      "rectangle"
      "rustdesk"
      "sabnzbd"
      #"screen-studio"
      "signal"
      #"silicon-labs-vcp-driver"
      #"slack"
      "spotify"
      "steam"
      "sublime-text"
      #"temurin@17"
      #"thunderbird"
      #"tigervnc-viewer"
      "visual-studio-code"
      "zed"
      "zen"
      #"zoom"
    ];
    brews = [
      "age"
      "xz"
      "glib"
      "ca-certificates"
      "awscli"
      "azure-cli"
      "cmake"
      "coreutils"
      "deno"
      "docker-compose"
      "esptool"
      "eza"
      "fd"
      "fzf"
      "gemini-cli"
      "gh"
      "git"
      "gnu-getopt"
      "helm"
      "helmfile"
      "jq"
      "k3d"
      "k9s"
      "ksops"
      "kubectx"
      "kustomize"
      "mage"
      "mkcert"
      "netlify-cli"
      "nmap"
      "node@24"
      "nvm"
      "ocrmypdf"
      "oh-my-posh"
      "opencode"
      "pnpm"
      "pulumi"
      "python@3.12"
      "rclone"
      "ripgrep"
      "sops"
      #"talosctl"
      "tcptraceroute"
      #"telnet"
      "tilt"
      "uv"
      "velero"
      "wakeonlan"
      "watch"
      "wget"
      # "wireguard-tools"
      "zoxide"
      "zsh"
      #"aws/tap/ec2-instance-selector"
      "hashicorp/tap/terraform"
      "kluctl/tap/kluctl"
      "oven-sh/bun/bun"
    ];
    taps = [
      "aws/tap"
      "hashicorp/tap"
      "jandedobbeleer/oh-my-posh"
      "kluctl/tap"
      "oven-sh/bun"
      "siderolabs/tap"
      "sst/tap"
      #"stripe/stripe-cli"
      #"supabase/tap"
    ];

    # masApps = {
    #   "Bitwarden" = 1352778147;
    #   "WireGuard" = 1451685025;
    # };
  };
}
