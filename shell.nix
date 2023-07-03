{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs.buildPackages; [

    zip
    unzip
    python312
    epubcheck
    jdk
    inotify-tools

  ];
}

