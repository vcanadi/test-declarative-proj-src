let
  hs-job0 = { nixpkgs ? <nixpkgs>, system ? builtins.currentSystem } :
  let 
    pkgs = import nixpkgs {};
  in
  with pkgs;
  pkgs.releaseTools.nixBuild {
    name = "simple";
    buildCommand = '' 
      echo -------------------
      echo ----IN_BUILDER-----
      echo -------------------
      export PATH="$coreutils/bin:$gcc/bin"
      mkdir $out
      gcc -o $out/simple $src
    '';

    inherit gcc coreutils;

    src = builtins.toFile "tmp_simple.c" ''
      void main () { 
        puts ("Simple!");
      }
    '';
    inherit system;
    meta.maintainer = "vito.canadi@gmail.com";
  };
in {
  hs-job0-0 = hs-job0; 
  #hs-job0-1 = hs-job0; 
}

