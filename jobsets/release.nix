{ nixpkgs , declInput ? {} } : 
let 
  pkgs = import nixpkgs {};

  utils = import ../utils.nix;
  placeBashLogCall = utils.mkPlaceBashLogCall "JOB_FOR_CREATING_JOBSETS"; 

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
    nixexprpath = "jobs/release.nix";
    nixexprinput = "jobsSrc";
    description = "Builds for deployments";  
    inputs = {
      jobsSrc = { 
        type = "path"; 
        value = "/home/hydra/test-declarative-proj-src"; 
        emailresponsible = false; 
      };
      nixpkgs = { 
        type = "git";
        value = "https://github.com/NixOS/nixpkgs-channels.git nixos-17.09";
        emailresponsible = false;
      };
      system = {
        type = "string";
        value = builtins.currentSystem;
        emailresponsible = false;
      };
      logpath = {
        name = "logpath";
        type = "path";
        value = utils.mkLogPath "SIMPLE_PROGRAM";
        emailresponsible = false;
      };

    };
  };

  jobsetAttrs = pkgs.lib.mapAttrs (name : settings : settings // defaultSettings ) { 
    trivialJobset0 = trivialJobset; 
    #trivialJobset1 = trivialJobset; 
  };
  jobsetJson = pkgs.writeText "jobsets.json" (builtins.toJSON jobsetAttrs );
in {
  jobsets = pkgs.releaseTools.nixBuild {
    name = "job-for-creating-jobsets";
    buildCommand = ''
      #${placeBashLogCall "BUILD_COMMAND"}
      cp ${jobsetJson} $out
    '';
    passAsFile = [ "buildCommand" ];
    src = ./.;
    postInstall = ''
      #${placeBashLogCall "POST_INSTALL"}
    '';

    meta.maintainer = "vito.canadi@gmail.com";
  };
}
