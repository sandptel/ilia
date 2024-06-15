
{
  pkgs ? import <nixpkgs> {}
}:

pkgs.stdenv.mkDerivation {
  pname = "ilia";
  version = "main";
  
  src = ./.;

  nativeBuildInputs = [

  ];

  buildInputs = with pkgs;[
    makeWrapper
    json-glib
    gettext
    gobject-introspection
    intltool
    gtk3
    tracker
    meson
    vala
    cmake
    pkg-config
    libgee
    ninja
    gtk-layer-shell
  ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    cp src/ilia $out/share
    runHook postInstall
  '';

  postInstall = ''
    mkdir -p $out/share/glib-2.0/schemas/
    glib-compile-schemas --targetdir=$out/share/glib-2.0/schemas $src/data
    makeWrapper $out/share/ilia $out/bin/ilia --set GSETTINGS_SCHEMA_DIR $out/share/gsettings-schemas/ilia-main/glib-2.0/schemas
  '';

  meta = {
    mainProgram = "ilia";
    description = "A GTK-based Desktop Executor";
    homepage = "https://github.com/regolith-linux/ilia";
    license = pkgs.lib.licenses.gpl3Plus;
  };
}