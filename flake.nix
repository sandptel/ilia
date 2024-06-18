{
  description = "Ilia";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let 
  system= "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
  in
   {
    packages.${system}.default = import ./nixos/default.nix{inherit pkgs;};
     devShells.${system}.default = pkgs.mkShell{
      nativeBuildInputs =[
        (import ./nixos/default.nix{inherit pkgs;})
      ];
     };
  };
}
