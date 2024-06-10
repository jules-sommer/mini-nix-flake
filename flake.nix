{
  description = "NixOS configuration";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs/master";
    staging.url = "github:nixos/nixpkgs/staging-next";
    stable.url = "github:nixos/nixpkgs/nixos-24.05";

    oxalica = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "master";
    };

    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };

    xeta-utils = {
      url = "/home/jules/000_dev/000_config/050_xeta-utils";
      inputs.nixpkgs.follows = "master";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "master";
    };

    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "master";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "master";
    };

    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "master";
    };

    zls = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "master";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-vdesk = {
      url = "github:levnikmyskin/hyprland-virtual-desktops";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "master";
    };

    pyprland = {
      url = "github:hyprland-community/pyprland";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "master";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "master";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils-plus,
      master,
      unstable,
      stable,
      ...
    }:
    let
      system = "x86_64-linux";
      nixpkgs = {
        master = master.legacyPackages.${system};
        unstable = unstable.legacyPackages.${system};
        stable = stable.legacyPackages.${system};
      };

      lib = master.lib // import ./lib { inherit (inputs) nixpkgs; };
    in
    flake-utils-plus.outputs.lib.mkFlake {
      inherit self inputs;

      channelsConfig = {
        allowUnfree = true;
      };

      homeManagerModules = flake-utils-plus.lib.exportModules [
        ./modules/home/hyprland/default.nix
        ./modules/home/nushell/default.nix
        ./modules/home/tty/default.nix
        ./modules/home/starship/default.nix
      ];

      nixosModules = flake-utils-plus.lib.exportModules [
        ./modules/nixos/hyprland/default.nix
        ./modules/nixos/xdg/default.nix
        ./modules/nixos/development/default.nix
        ./modules/nixos/development/rust/default.nix
        ./modules/nixos/development/ocaml/default.nix
        ./modules/nixos/development/zig/default.nix
        ./modules/nixos/development/nix/default.nix
        ./modules/nixos/development/go/default.nix
        ./modules/nixos/development/typescript/default.nix
        ./modules/nixos/development/c/default.nix
      ];

      hosts.xeta = {
        channelName = "master";
        specialArgs = {
          inherit lib nixpkgs;
          inputs = inputs // { };
          host = "xeta";
        };
        modules = [
          ./system/default.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
}
