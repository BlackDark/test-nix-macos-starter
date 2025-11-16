{ self, ... }:
{
  # touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # only initally set this to get faster installs without having to always give access
  # security.sudo.extraConfig = ''
  #   marbaced ALL=(ALL:ALL) NOPASSWD: ALL
  # '';


  # system defaults and preferences
  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtyRev or null;

    startup.chime = false;

    defaults = {

      screensaver.askForPasswordDelay = 10;

      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };

      finder = {
        AppleShowAllFiles = true; # hidden files
        AppleShowAllExtensions = true; # file extensions
        _FXShowPosixPathInTitle = false; # title bar full path
        ShowPathbar = true; # breadcrumb nav at bottom
        ShowStatusBar = true; # file count & disk space
      };

      dock = {
        orientation = "left"; # dock on the left side
        autohide = true; # automatically hide the dock
        show-recents = false; # disable recent apps in Dock
        
        # Configure which apps appear in the Dock
        # Add paths to applications you want pinned to the Dock
        persistent-apps = [
          "/Applications/Discord.app"
          "/Applications/iTerm.app"
          "/Applications/Microsoft Outlook.app"
          "/Applications/Spotify.app"
          "/Applications/Zen.app"
          "/System/Applications/App Store.app"
          "/System/Applications/Apps.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/Messages.app"
          "/System/Applications/Notes.app"
          "/System/Applications/System Settings.app"
        ];
        
        # You can also configure persistent-others (folders, documents, etc.)
        # persistent-others = [
        #   "~/Downloads"
        # ];
      };

      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };

      # Menu bar configuration
      # Control which items appear in the menu bar
      # "com.apple.controlcenter" = {
      #   # Show/hide Control Center items in menu bar
      #   # Available items: Bluetooth, WiFi, AirDrop, Focus, Screen Mirroring, Sound, Battery, etc.
      #   # Set to false to hide, true to show
      #   "NSStatusItem Visible Bluetooth" = true;
      #   "NSStatusItem Visible WiFi" = true;
      #   "NSStatusItem Visible AirDrop" = false;
      #   "NSStatusItem Visible FocusModes" = true;
      #   "NSStatusItem Visible ScreenMirroring" = false;
      #   "NSStatusItem Visible Sound" = true;
      #   "NSStatusItem Visible Battery" = true;
      #   "NSStatusItem Visible NowPlaying" = false;
      # };

      # # Menu bar extras (legacy menu bar items)
      # "com.apple.systemuiserver" = {
      #   # Configure which menu bar extras are shown
      #   # You can also use "menuExtras" array to specify exact extras
      #   # menuExtras = [
      #   #   "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
      #   #   "/System/Library/CoreServices/Menu Extras/Volume.menu"
      #   # ];
      # };

      # # Battery menu bar - show percentage
      # "com.apple.menuextra.battery" = {
      #   ShowPercent = true; # Show battery percentage
      # };

      # # Clock menu bar - format options
      # "com.apple.menuextra.clock" = {
      #   DateFormat = "EEE MMM d  h:mm a"; # Custom date format
      #   # Options:
      #   # "EEE MMM d  h:mm a" = "Mon Jan 1  2:30 PM"
      #   # "EEE d MMM  HH:mm" = "Mon 1 Jan  14:30"
      #   # "EEE MMM d  HH:mm" = "Mon Jan 1  14:30"
      #   ShowSeconds = false; # Show seconds in time
      #   FlashDateSeparators = false; # Flash the separators
      # };
    };

    # Prevent macOS from creating .DS_Store and ._* files on USB devices and network shares
    # Using activation script since com.apple.desktopservices is not directly supported in defaults
    activationScripts.preventDSStore = ''
      # Prevent .DS_Store files on network shares
      defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
      
      # Prevent .DS_Store files on USB devices
      defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
    '';
  };
}
