let
  pkgs = import <nixpkgs> {};  
  hs-proj0 = { system ? builtins.currentSystem } :
  pkgs.stdenv.mkDerivation {
    name = "hs-proj0";
    src = ./.;
    buildPhase = ''
      echo buildPhase 
      echo src: $src
      echo out: $out
      ls $out
    '';
    installPhase = '' 
      echo installPhase
      echo src: $src
      echo out: $out
    '';
  };
in {
  hs-proj0-0 = hs-proj0; 
  hs-proj0-1 = hs-proj0; 
}


