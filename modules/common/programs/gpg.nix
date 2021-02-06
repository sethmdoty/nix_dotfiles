{ pkgs, ... }:

{
  home-manager.users.sethdoty.programs.gpg = {
    enable = true;
    settings = {
      auto-key-retrieve = true;
      no-emit-version = true;
      cert-digest-algo = "SHA256";
      no-comments = false;
      personal-cipher-preferences = "AES AES256 AES192 CAST5";
      personal-digest-preferences = "SHA256 SHA512 SHA384 SHA224";
      ignore-time-conflict = true;
      allow-freeform-uid = true;
      default-key = "15305FB3273A136CE971B47F187148A9EE3AD80F";
      use-agent = true;
    };
  };
}
