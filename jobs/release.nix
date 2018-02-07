let
  hs-job0 = { nixpkgs ? <nixpkgs> } :
  let
    pkgs = import nixpkgs {};
  in
  pkgs.releaseTools.nixBuild {
    name = "simple-program";
    buildCommand = ''touch $out '';
    passAsFile = [ "buildCommand" ];
    src = "";
  };
in {
  hs-job0-0 = hs-job0;
}

