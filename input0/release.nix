let
  hs-job0 = { nixpkgs, system ? builtins.currentSystem } :
  let 
    pkgs = import nixpkgs {};
  in
  pkgs.stdenv.mkDerivation {
    name = "hs-job";
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
  hs-job0-0 = hs-job0; 
  #hs-job0-1 = hs-job0; 
}


