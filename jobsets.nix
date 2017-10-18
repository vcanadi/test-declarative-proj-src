{ nixpkgs ? <nixpkgs>, declInput ? {} } : 
let 
  pkgs = import nixpkgs {};
  jobsetAttrs = {};
  jobsetJson = pkgs.writeText "jobsets.json" (builtins.toJSON jobsetAttrs);

in {
  jobsets = pkgs.runCommand "jobsets.json" {} ''
    cat <<EOF
    ${builtins.toJSON declInput}
    EOF
    cp ${jobsetJson} $out
  '';
}
