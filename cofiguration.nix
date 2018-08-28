{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    cleanTmpDir = true;
    consoleLogLevel = 3;

    kernelParams = [
      "quiet"
      "elevator=deadline"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 5;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_background_ratio" = 25;
      "vm.dirty_background_bytes" = 0;
      "vm.dirty_ratio" = 75;
      "vm.dirty_bytes" = 0;
      "vm.dirty_expire_centisecs" = 6000;
      "vm.dirty_writeback_centisecs" = 2000;
      "ipv6.disable" = 1;
    };

  };

  networking = {
    hostName = "nix-demigod-von-L";
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 localhost nix-demigod-von-L
    '';

    enableIPv6 = false;

    dhcpcd = {
      extraConfig = ''
        noarp
        ipv4only
        noipv6
      '';
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Asia/Kolkata";

  fonts = {
    enableFontDir = true;
    enableCoreFonts = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      corefonts
      dejavu_fonts
      font-droid
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      source-code-pro
      terminus_font
      ttf_bitstream_vera
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi
    curl
    dunst
    file
    git
    ntfs3g
    screen
    sshfsFuse
    unzip
    vim
    sublime3
    wget
    which
    zip
  ];

  nix.useSandbox = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  systemd = {
    services.systemd-udev-settle.enable = false;
  };

  programs = {
    bash = {
      enableCompletion = true;
      shellAliases = {
        ls = "ls --color=auto";
        la = "ls -la";
        vim = "nvim";
      };
    };

    gnupg.agent = {
      enable = true; enableSSHSupport = true;
    };

    light.enable = true;
    adb.enable = true;
  };

  powerManagement.enable = true;

  services = {
    tlp = {
      enable = true;
      extraConfig = ''
        USB_BLACKLIST_PHONE=1
      '';
    };

    nscd.enable = false;
    upower.enable = true;
    fstrim.enable = true;

    openssh = {
      enable = true;
      ports = [ 22 ];
    };

    acpid.enable = true;
    logind = {
      lidSwitchDocked = "suspend";
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };

    thermald.enable = true;

    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = [ "intel" ];
      xkbVariant = "mac";
      xkbOptions = "caps:swapescape";

      libinput = {
        enable = true;
        accelSpeed = "0.6";
        disableWhileTyping = true;
        naturalScrolling = true;
        tappingDragLock = false;
        additionalOptions = ''
          Option "TappingDrag" "off"
        '';
      };

      displayManager.sddm = {
        enable = true;
      };

      windowManager = {
        default = "none";
      };

      desktopManager = {
	plasma5.enable = true;
        xterm.enable = false;
      };

    };
      
  };

  sound.enable = true;

  hardware = {
    cpu.intel.updateMicrocode = true;
    
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    bluetooth.enable = false;
    opengl.extraPackages = [ pkgs.vaapiIntel pkgs.vaapiVdpau ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  users.extraUsers.cc = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    description = "Ameya Shenoy";
    extraGroups = [
      "wheel"
      "adbusers"
      "systemd-journal"
      "networkmanager"
      "audio"
      "video"
    ];
    createHome = true;
    home = "/home/cc";
  };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
