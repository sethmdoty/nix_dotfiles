{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "85.0.2";

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
    sha256 = "0wq2ng17kcp4wlfwnqc9dih9vn6np4ya26n3qscxzjd3q2dz79y6";
  };

  meta = with stdenv.lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox";
    maintainers = [ maintainers.sdoty ];
    platforms = platforms.darwin;
  };
}
