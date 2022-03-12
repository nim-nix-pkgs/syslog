{
  description = ''Syslog module.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-syslog-master.flake = false;
  inputs.src-syslog-master.owner = "FedericoCeratto";
  inputs.src-syslog-master.ref   = "refs/heads/master";
  inputs.src-syslog-master.repo  = "nim-syslog";
  inputs.src-syslog-master.type  = "github";
  
  inputs."nake".dir   = "nimpkgs/n/nake";
  inputs."nake".owner = "riinr";
  inputs."nake".ref   = "flake-pinning";
  inputs."nake".repo  = "flake-nimble";
  inputs."nake".type  = "github";
  inputs."nake".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nake".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-syslog-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-syslog-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}