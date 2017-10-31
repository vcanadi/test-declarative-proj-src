{ nixpkgs , trivialJobsetsPrsJSON,  declInput } : 
let 
  pkgs = import nixpkgs {};

  mkFetchGithub = value: {
    inherit value;
    type = "git";
    emailresponsible = false;
  };

  utils = import ../utils.nix;
  placeBashLogCall = utils.mkPlaceBashLogCall "JOB_FOR_CREATING_JOBSETS"; 

  trivialJobsetsPrs = builtins.fromJSON (builtins.readFile trivialJobsetsPrsJSON);

  defaultSettings = {
    enabled = 1;
    hidden = false;
    keepnr = 1;
    schedulingshares = 42;
    checkinterval = 5;
    enableemail = false;
    emailoverride = "";
  };

  mkTrivialJobset = num: info: {
    name = "trivialJobsetSrc${num}";
    value = {
      description = "PR ${num}: ${info.title}";
      nixexprinput = "trivial";
      nixexprpath = "release.nix";
      inputs = {
        nixpkgs = mkFetchGithub "https://github.com/NixOS/nixpkgs-channels.git nixos-17.09";
        trivialJobsetSrc = mkFetchGithub "https://github.com/${info.head.repo.owner.login}/${info.head.repo.name}.git ${info.head.ref}";
      };
    };
  };

  trivialJobsetHardCoded = {
    nixexprpath = "jobs/release.nix";
    nixexprinput = "trivialJobsetSrc";
    description = "Builds for deployments";  
    inputs = {
      #jobsSrc = { 
        #type = "path"; 
        #value = "/home/hydra/test-declarative-proj-src"; 
        #emailresponsible = false; 
      #};
      nixpkgs = mkFetchGithub "https://github.com/NixOS/nixpkgs-channels.git nixos-17.09";
      trivialJobsetSrc = mkFetchGithub "https://github.com/vcanadi/test-declarative-proj-src.git";
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

  trivialJobsets = pkgs.lib.listToAttrs (pkgs.lib.mapAttrsToList mkTrivialJobset trivialJobsetsPrs);

  jobsetAttrs = pkgs.lib.mapAttrs (name : settings : settings // defaultSettings ) ({ 
    trivialJobsetHardCoded = trivialJobsetHardCoded; 
  } // 
  trivialJobsets
  );

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
