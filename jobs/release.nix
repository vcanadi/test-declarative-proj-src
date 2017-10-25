let
  hs-job0 = { nixpkgs ? <nixpkgs>, system ? builtins.currentSystem } :
  let 
    pkgs = import nixpkgs {};
  in
  with pkgs;
  pkgs.releaseTools.nixBuild {
    name = "simple-program";
    buildCommand = '' 
      echo ---SIMPLE_PROGRAM_BUILD_COMMAND---
      export PATH="$coreutils/bin:$gcc/bin"
      mkdir $out
      gcc -o $out/simple $src
    '';
    passAsFile = [ "buildCommand" ];

    inherit gcc coreutils;

    src = builtins.toFile "tmp_simple.c" ''
      void main () { 
        puts ("Simple!");
      }
    '';
    inherit system;
    meta.maintainer = "vito.canadi@gmail.com";

    postInstall = '' 
      echo ---SIMPLE_PROGRAM_POST_INSTALL---
    '';

  };
in {
  hs-job0-0 = hs-job0; 
  #hs-job0-1 = hs-job0; 
}

