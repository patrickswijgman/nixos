{ pkgs, lib, ... }:

with lib;

pkgs.rustPlatform.buildRustPackage {
  pname = "helix";
  version = "unstable";

  src = fetchFromGithub {
    owner = "helix-editor";
    repo = "helix";
    rev = "761f70d61179f38152e76c1f224589a53b62d00f";
    sha256 = "";
  };

  cargoHash = "";

  nativeBuildInputs = [
    pkgs.git
    pkgs.installShellFiles
  ];

  cargoBuildFlags = [
    "--path"
    "helix-term" # Ensuring the helix-term crate is built
    "--locked"
  ];

  env.HELIX_DEFAULT_RUNTIME = "${placeholder "out"}/lib/runtime";

  postInstall = ''
    # not needed at runtime
    rm -r runtime/grammars/sources

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
