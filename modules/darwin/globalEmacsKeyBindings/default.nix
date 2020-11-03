{ pkgs, config, lib, ... }:
lib.mkIf (pkgs.stdenv.isDarwin) {
  home-manager.users.sethdoty = {
    home.file."Library/KeyBindings/DefaultKeyBinding.dict".source =
      ./EmacsOptBindings.dict;
  };
}
