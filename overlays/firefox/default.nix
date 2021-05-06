{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "88.0.1";

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
    sha256 = "0z9p6jng7is8pq21dffjr6mfk81q08v99fwmhj22g9b1miqxrvcz";
  };

  meta = with lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox";
    maintainers = [ maintainers.sdoty ];
    platforms = platforms.darwin;
  };
}
