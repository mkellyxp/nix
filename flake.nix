{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    system = "x86-64_linux";

    # Set unstable variable to import & define unstable-nixpkgs
    # By referencing unstable in specialArgs, unstable packages can then be set within environment.systemPackages using unstable.package
      # eg: unstable.cowsay
    unstable = import inputs.unstable-nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [ ];
    };
  in {
    nixosConfigurations = {

      framework = nixpkgs.lib.nixosSystem {
        system = system;
        # Sets inputs & unstable to be eligible to be referenced within .nix top functions { config, lib, pkgs, unstable, ... }:
        specialArgs = { inherit inputs unstable; };
        modules = [
          # Import .nix files
          ./configuration.nix

          # Import a directory (with a default.nix inside)
          # ./example

          # Import nixosModules from flake inputs
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd

          # You can also define config options within 'modules'
          {
            networking.hostName = "framework";
          }
        ];
      };

      garage = nixpkgs.lib.nixosSystem {
        system = system;
        # Sets inputs & unstable to be eligible to be referenced within .nix top functions { config, lib, pkgs, unstable, ... }:
        specialArgs = { inherit inputs unstable; };
        modules = [
          # Import .nix files
          ./configuration.nix

          # Import a directory (with a default.nix inside)
          # ./example

          # You can also define config options within 'modules'
          {
            networking.hostName = "garage";
          }
        ];
      };

      
    };
  };
}
