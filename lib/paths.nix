{ self, lib, ... }:

with builtins;
with lib; rec {
  # ...
  dotFilesDir = toString ../.;
  modulesDir = "${dotFilesDir}/modules";
  configDir = "${dotFilesDir}/conf.d";
  homeDir = "/home/${
      let name = getEnv "USERNAME";
      in if elem name [ "" "root" ] then "sethdoty" else name
    }";
}
