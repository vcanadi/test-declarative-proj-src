let
  hs-proj0 = { nixpkgs, system ? builtins.currentSystem } :
  let 
    pkgs = import nixpkgs {};
  in
  pkgs.stdenv.mkDerivation {
    name = "hs-proj0";
    src = ./.;
    buildPhase = ''
      echo BUILD_PHASE 
      echo src: $src
      echo out: $out
      ls $out
    '';
    installPhase = '' 
      echo INSTALL_PHASE 
      echo src: $src
      echo out: $out
    '';
  };
in {
  hs-proj0-0 = hs-proj0; 
  #hs-proj0-1 = hs-proj0; 
}


