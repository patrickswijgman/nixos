{ config, pkgs, ... }:

pkgs.vimUtils.buildVimPlugin {
  name = "fleet-nvim";
  src = pkgs.fetchFromGitHub {
    owner = "patrickswijgman";
    repo = "fleet-theme-nvim";
    rev = "d12bcbc28524e0b244a5d956a5029f042cb8ef77";
    hash = "sha256-wuK5c4xlsOcPevDNfeuGF/XhvKPx1Mcqj/MBalr3J2U=";
  };
}
