# dotfiles

## Setup

After cloning the repo

1. run the [nix installer](https://github.com/DeterminateSystems/nix-installer)

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

2. run home-manager

```
nix run home-manager/release-24.11 -- switch -b backup --flake .
```

Alternatively create a nix shell after installing nix(if git is not installed)

```
nix shell nixpkgs#home-manager nixpkgs#git
```

and run

```
home-manager switch -b backup --flake .
```

Other stuff

```
sudo rpm-ostree initramfs-etc --track=/etc/vconsole.conf
```

```
flatpak install org.wezfurlong.wezterm
```

add this to .config/topgrade.toml under '[linux]'

```
nix_arguments = "--flake"

home_manager_arguments = ["--flake", "/home/user/dotfiles/"]
```
