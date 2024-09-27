{
  pkgs,
  lib,
  ...
}:

with lib;

{
  simple-completion-language-server = pkgs.rustPlatform.buildRustPackage {
    pname = "simple-completion-language-server";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "estin";
      repo = "simple-completion-language-server";
      rev = "40db0768e8b0b580a8e894fcd95158bd25f28735";
      sha256 = "sha256-4wceSbjDvzr2dcaYq5I/KRBTFgvolvnF8sECpKe/UYE=";
    };

    cargoHash = "sha256-bdhHcp6rzrh5O5+r1rwj0WT696iqEW+i/I7dq2PGuFw="; # Replace with correct hash after build

    nativeBuildInputs = [ pkgs.pkg-config ];

    # Don't run tests.
    doCheck = false;

    meta = {
      description = "Simple completion language server";
      license = licenses.mit;
      maintainers = with maintainers; [ patrickswijgman ];
    };
  };
}
