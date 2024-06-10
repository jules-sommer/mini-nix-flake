{ lib, inputs, ... }:
let
  nix-std = inputs.nix-std.outputs.lib;
  getWorkDir = builtins.getEnv "PWD";
in
{
  std = {
    inherit (nix-std)
      list
      types
      nonempty
      tuple
      bool
      serde
      set
      string
      path
      nullable
      num
      optional
      regex
      ;
  };

  flake-utils = inputs.flake-utils-plus.outputs.lib;
  flake-utils-plus = inputs.flake-utils-plus.outputs.lib;
}
