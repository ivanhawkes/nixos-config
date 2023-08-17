# My personal configuration files for NixOS.

## Finish installing NixOS

	* Open up Firefox.
	* Log into my password manager.
	* Use that to log into Google, Firefox.
	* Sync my Firefox account.
	
## Update the OS.

Follow the steps in the (guide)[https://nixos.org/manual/nixos/stable/#sec-upgrading].

Alternatively - quick steps.

Check which channel you are using.

```
sudo nix-channel --list
```

Upgrade it and switch.

```
sudo nixos-rebuild switch --upgrade
```
You can have it auto update periodically using this:

```
system.autoUpgrade.enable = true;
system.autoUpgrade.allowReboot = false;
```

## Get my SSH keys.

```
cd ~
scp ivan@<<SECRETS>>:/home/ivan/.ssh/* ~/.ssh
```

## Start by selecting a machine name.

```
export MACHINE=<<MACHINE_NAME>>
echo $MACHINE
```

## Start a Nix shell so I can use Git and VSCodium for editing.
```
nix-shell -p vscodium git
```

## Clone the repository.

```
git clone --recursive git@github.com:ivanhawkes/nixos-config.git
cd nixos-config
```

## First run...

If you don't already have a folder and configuration files for this machine you will need to make some and copy the existing configuration. It's highly reccomended you make backups of the configuration files prior to rebuilding.

```
## Force it to create new definitions if desired.
sudo nixos-generate-config --force

## Make a new configuration set for this machine.
cp /etc/nixos/configuration.nix machines/$MACHINE/configuration.nix
cp /etc/nixos/hardware-configuration.nix machines/$MACHINE/hardware-configuration.nix
```

## Replace the existing NixOS configuration.

```
## Just have a peek first.
ls -al /etc/nixos/

## Remove the existing files.
sudo rm -f /etc/nixos/configuration.nix
sudo rm -f /etc/nixos/hardware-configuration.nix

## Replace with our versions.
sudo ln -s ~/nixos-config/machines/$MACHINE/configuration.nix /etc/nixos/configuration.nix
sudo ln -s ~/nixos-config/machines/$MACHINE/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

## Test the new build.
sudo nixos-rebuild test
```

## Move in my typical shell scripts.

```
# Shell configuration.
ln -s nixos-config/users/ivan/.bashrc .bashrc
ln -s nixos-config/users/ivan/.profile .profile
ln -s nixos-config/users/ivan/.imwheel .imwheel
```

# Handy scripts I use.
```
# Fast logins to SSH servers.
ln -s $HOME/nixos-config/users/ivan/bin/de10-nano $HOME/bin/de10-nano
ln -s $HOME/nixos-config/users/ivan/bin/dns-server $HOME/bin/dns-server
ln -s $HOME/nixos-config/users/ivan/bin/mercury $HOME/bin/mercury
ln -s $HOME/nixos-config/users/ivan/bin/venus $HOME/bin/venus

# Janky backup.
ln -s $HOME/nixos-config/users/ivan/bin/backup.sh $HOME/bin/backup.sh

# Set the mouse speed and scrolling speed.
ln -s $HOME/nixos-config/users/ivan/bin/mousespeed.sh $HOME/bin/mousespeed.sh
```

## XXX.

```
```


## XXX.

```
```


## XXX.

```
```


## Git config

```
git config --global user.email "ivan.hawkes@gmail.com"
git config --global user.name "Ivan Hawkes"
git config --global init.defaultBranch main
```

## Reload the OS.
```
sudo nano /etc/nixos/hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ~/nixos-config/servers/$MACHINE/hardware-configuration.nix

sudo nano /etc/nixos/configuration.nix
cp /etc/nixos/configuration.nix ~/nixos-config/servers/$MACHINE/configuration.nix

sudo nixos-rebuild switch

sudo nixos-generate-config
```

## Mount the drives.
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



## TODO:

Pretty much all of it.
	* dotfiles
	* vscode config
	* bin folder
	* git config in home folder
	* bash enhancements e.g. ll isn't listing -al



## Home manager.

Your configuration is stored in ~/.config/nixpkgs/home.nix. Each time you modify it, rerun home-manager switch for changes to have effect.

```
nano ~/.config/nixpkgs/home.nix
home-manager switch
```
