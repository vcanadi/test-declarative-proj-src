{
  hs-job0 = { nixpkgs ? <nixpkgs> } :
    let
      pkgs = import nixpkgs {};
    in
    pkgs.runCommand "hs-job-name" {} "";
}

