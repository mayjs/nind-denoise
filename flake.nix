{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: let pkgs = nixpkgs.legacyPackages.x86_64-linux; in {

    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        (python3.withPackages (ps: with ps; [ torch configargparse pyyaml torchvision opencv4 onnx
            (
              buildPythonPackage rec {
                pname = "piqa";
                version = "1.3.1";
                src = fetchPypi {
                  inherit pname version;
                  sha256 = "sha256-BwYAlQ1XlgsqgHA9b59z5iH6MVpQqijRPtph4aYubF0=";
                };
                doCheck = false;
                propagatedBuildInputs = [
                  # Specify dependencies
                ];
              }
            )
        ]))
        exiftool
      ];
    };
  };
}
