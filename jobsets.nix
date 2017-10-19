{ nixpkgs ? <nixpkgs>, declInput ? {} } : 
let 
  pkgs = import nixpkgs {};


  defaultSettings = {
    enabled = 1;
    hidden = false;
    keepnr = 1;
    schedulingshares = 42;
    checkinterval = 5;
  };

  trivialJobset = {
    nixexprpath = "input0/release.nix";
    nixexprinput = "input0";
    description = "Builds for deployments";  
    inputs = {
      input0 = { 
        type = "git"; 
        value = "https://github.com/vcanadi/test-declarative-proj-src"; 
        emailresponsible = true; 
      };
    };
    enableemail = true;
  };

  jobsetAttrs = pkgs.lib.mapAttrs (name : settings : settings // defaultSettings ) { 
    trivialJobset = trivialJobset; 
  };
  jobsetJson = pkgs.writeText "jobsets.json" (builtins.toJSON jobsetAttrs);
in {
  jobsets = pkgs.runCommand "jobsets.json" {} ''
    cp ${jobsetJson} $out
  '';
}
