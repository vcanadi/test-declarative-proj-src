let pkgs = import <nixpkgs> {}; in {
	jobsets = with pkgs.lib; pkgs.writeFile "spec.json" {} ''
	'';
}
