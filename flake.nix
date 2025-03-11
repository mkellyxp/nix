{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
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
        modules = [
          /etc/nixos/configuration.nix
          {
            networking.hostName = "thelio";
          }
        ];
      };
      
    };
  };  
}
