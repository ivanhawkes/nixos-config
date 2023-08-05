# My personal configuration files for NixOS.

# Get my SSH keys.

```
scp ivan@odroid-hc2:/home/ivan/.ssh/* ~/.ssh
```

# TODO:

Pretty much all of it.
	* dotfiles
	* vscode config
	* bin folder
	* git config in home folder
	* bash enhancements e.g. ll isn't listing -al
	* 

# Git config

```
git config --global user.email "ivan.hawkes@gmail.com"
git config --global user.name "Ivan Hawkes"
git config --global init.defaultBranch main
```

# Reload the OS.
```
sudo nano /etc/nixos/hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ~/nixos-config/servers/lythir/hardware-configuration.nix

sudo nano /etc/nixos/configuration.nix
cp /etc/nixos/configuration.nix ~/nixos-config/servers/lythir/configuration.nix

sudo nixos-rebuild switch

sudo nixos-generate-config
```

# Mount the drives.
```
sudo mkdir /mnt/b
sudo mkdir /mnt/ce
sudo mkdir /mnt/d
sudo mkdir /mnt/e
sudo mkdir /mnt/g
#sudo mkdir /mnt/w

sudo mount -t ntfs /dev/sda2 /mnt/b
sudo mount -t ntfs /dev/sdc3 /mnt/c
sudo mount -t ntfs /dev/nvme0n1p2 /mnt/d
sudo mount -t ntfs /dev/sdd1 /mnt/g
sudo mount -t ntfs /dev/sdd2 /mnt/e
#sudo mount -t ntfs /dev/sdd3 /mnt/w


 fileSystems."/mnt/b" =
    { device = "/dev/dev/sda2";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };

 fileSystems."/mnt/c" =
    { device = "/dev/sdc3";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };

 fileSystems."/mnt/d" =
    { device = "/dev/nvme0n1p2";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };

 fileSystems."/mnt/g" =
    { device = "/dev/sdd1";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };

 fileSystems."/mnt/e" =
    { device = "/dev/sdd2";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };

```

# Home manager.

Your configuration is stored in ~/.config/nixpkgs/home.nix. Each time you modify it, rerun home-manager switch for changes to have effect.

```
nano ~/.config/nixpkgs/home.nix
home-manager switch
```
