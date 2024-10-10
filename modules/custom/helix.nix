{ pkgs, lib, ... }:

with lib;

pkgs.rustPlatform.buildRustPackage rec {
  pname = "helix";
  version = "unstable";

  src = pkgs.fetchFromGitHub {
    owner = "helix-editor";
    repo = pname;
    rev = "761f70d61179f38152e76c1f224589a53b62d00f";
    sha256 = "sha256-amGNilpQ/vohlgerF/5D4QNsXCRbh2H06nmWyz/xyS8=";
  };

  cargoHash = "sha256-AySR2NdGo0GajBF7jJS2IDitXWhcvV3K7Io8ZE21KlM=";

  nativeBuildInputs = [
    pkgs.installShellFiles
  ];

  # Nix package builds do not allow network access, so grammars need to be fetched and built afterwards (requires gcc):
  # hx --grammar fetch
  # hx --grammar build
  env.HELIX_DISABLE_AUTO_GRAMMAR_BUILD = "true";
  env.HELIX_DEFAULT_RUNTIME = "${placeholder "out"}/lib/runtime";

  buildPhase = ''
    cargo build --package=helix-term --release --locked
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/hx $out/bin

    mkdir -p $out/lib
    cp -r runtime $out/lib

    installShellCompletion contrib/completion/hx.{bash,fish,zsh}

    mkdir -p $out/share/{applications,icons/hicolor/256x256/apps}
    cp contrib/Helix.desktop $out/share/applications
    cp contrib/helix.png $out/share/icons/hicolor/256x256/apps
  '';

  meta = with lib; {
    description = "A post-modern modal text editor";
    homepage = "https://helix-editor.com";
    license = licenses.mpl20;
    mainProgram = "hx";
    maintainers = with maintainers; [ patrickswijgman ];
  };
}
