{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... } @ inputs: 

let

    # Set unstable variable to import & define unstable-nixpkgs
    # By referencing unstable in specialArgs, unstable packages can then be set within environment.systemPackages using unstable.package
      # eg: unstable.cowsay
    unstable = import inputs.unstable-nixpkgs {
      config = { allowUnfree = true; };
      overlays = [ ];
    };
  in {

  
    nixosConfigurations = {

      framework = nixpkgs.lib.nixosSystem {
        system = "x86-64_linux";
        modules = [
          /etc/nixos/configuration.nix
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          {
            networking.hostName = "framework";
          }
        ];
      };

      garage = nixpkgs.lib.nixosSystem {
        system = "x86-64_linux";
        modules = [
          /etc/nixos/configuration.nix
          {
            networking.hostName = "garage";
          }
        ];
      };

      thelio = nixpkgs.lib.nixosSystem {
        system = "x86-64_linux";
        specialArgs = { inherit inputs unstable; };
        modules = [
          /etc/nixos/configuration.nix
          {
            networking.hostName = "thelio";
          }
        ];
      };
      
      note = nixpkgs.lib.nixosSystem {
        system = "x86-64_linux";
        modules = [
          /etc/nixos/configuration.nix
          common/system.nix
          common/apps.nix
          common/lemp.nix
          gnome/gnome.nix
          {
            networking.hostName = "note";
          }
        ];
      };
      
    };

  };  
}
