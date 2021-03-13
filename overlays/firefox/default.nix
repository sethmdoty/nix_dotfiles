{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "86.0.1";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r Firefox.app "$out/Applications/Firefox.app"
  '';

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url =
      "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
    sha256 = "1cd55z11wpkgi1lnidwg8kdxy8b6p00arz07sizrbyiiqxzrmvx3";
  };

  meta = with lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox";
    maintainers = [ maintainers.sdoty ];
    platforms = platforms.darwin;
  };
}
