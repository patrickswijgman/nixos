# NixOS

# Config inspiration

[https://github.com/Misterio77/nix-starter-configs/blob/main/standard/flake.nix](https://github.com/Misterio77/nix-starter-configs/blob/main/standard/flake.nix)

# Packages and options

<aside>
📣

Make sure to look in the unstable channel

</aside>

Home manager options [https://home-manager-options.extranix.com/?query=&release=master](https://home-manager-options.extranix.com/?query=&release=master)

NixOS wiki [https://nixos.wiki/wiki/](https://nixos.wiki/wiki/) `!nix`

NixOS packages [https://search.nixos.org/packages?channel=unstable](https://search.nixos.org/packages?channel=unstable) `!nixpkgs`

NixOS older package versions [https://lazamar.co.uk/nix-versions/](https://lazamar.co.uk/nix-versions/)

NixOS options [https://search.nixos.org/options?channel=unstable](https://search.nixos.org/options?channel=unstable)

# Commands

### NixOS

```bash
# remove dangling packages and removes old generations
sudo nix-collect-garbage --delete-older-than 14d

# activate the new generation
sudo nixos-rebuild switch --flake ~/nixos#<flake-output-nixos-configuration>

# update all flake inputs
sudo nix flake update

# update single flake input
sudo nix flake lock --update-input <input>
```

### Folders and files

```bash
# set owner of folder and its files (recursive) to the current user
sudo chown -R $USER:users <folder>
```

### Fonts

```bash
# list all fonts
fc-list : family style

# clear font cache
fc-cache -r
```

### Bluetooth

```bash
# connect to a new device
bluetoothctl # enter bluetooth interactive mode
scan on # actively scan for devices
# get the mac address of the desired device
scan off
connect <mac-address>
devices # list connected devices
exit

# list current devices
bluetoothctl devices

# connect to (known) device
bluetoothctl connect <mac-address>

# trust (known) device to make it connect automatically
bluetoothctl trust <mac-address>
```

### WiFi

```bash
# list all wifi access points
nmcli device wifi list

# connect to a wifi access point
nmcli device wifi connect <SSID> password <PASSWORD>

# get status
nmcli device status
```

### Services

```bash
# all running system services
systemctl --type=service --state=running

# all running user services
systemctl --user --type=service --state=running

# status of all user services
systemctl --user status

# status of user service
systemctl --user status <service-name> # e.g. kanshi

# restart user service
systemctl --user restart <service-name> # e.g. kanshi
```
