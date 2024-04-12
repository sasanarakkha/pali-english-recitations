{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [

    zip
    unzip
    python312
    epubcheck
    jdk
    inotify-tools

  ];
}

