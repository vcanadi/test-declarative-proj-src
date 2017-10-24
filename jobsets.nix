{ nixpkgs , declInput ? {} } : 
let 
  pkgs = import nixpkgs {};


  defaultSettings = {
    enabled = 1;
    hidden = false;
    keepnr = 1;
    schedulingshares = 42;
    checkinterval = 5;
    enableemail = false;
    emailoverride = "";
  };

  trivialJobset = {
    nixexprpath = "input0/release.nix";
    nixexprinput = "input0";
    description = "Builds for deployments";  
    inputs = {
      input0 = { 
        type = "git"; 
        value = "https://github.com/vcanadi/test-declarative-proj-src"; 
        emailresponsible = false; 
      };
      nixpkgs = { 
        type = "git";
        value = "https://github.com/NixOS/nixpkgs-channels.git nixos-17.09";
        emailresponsible = false;
      };
    };
  };

  jobsetAttrs = pkgs.lib.mapAttrs (name : settings : settings // defaultSettings ) { 
    trivialJobset0 = trivialJobset; 
    #trivialJobset1 = trivialJobset; 
  };
  jobsetJson = pkgs.writeText "jobsets.json" (builtins.toJSON (builtins.trace jobsetAttrs jobsetAttrs));
in {
  jobsets = pkgs.runCommand "jobsets.json" {} ''
    cp ${jobsetJson} $out
  '';
}
