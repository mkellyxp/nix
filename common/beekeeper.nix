{ lib, fetchurl, appimageTools, pkgs }:

let
  pname = "beekeeper-studio";
  version = "5.1.5";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v${version}/Beekeeper-Studio-${version}.AppImage";
    name = "${pname}-${version}.AppImage";
    sha512 = "30cc0f8a25f66bb596c17dab34db0f554493d0ece47478fcd9ed3aa3f9b75c31b61a3fb0068983724eb4bc3a3ee561e08bac11b7a8349ee25e9cc390f0d75390";
    ## Run sha512sum Beekeeper-Studio-Ultimate-* to get checksum
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };
in
appimageTools.wrapType2 {
  inherit name src;

  multiPkgs = _: []; # no 32bit needed
  extraPkgs = pkgs: appimageTools.defaultFhsEnvArgs.multiPkgs pkgs ++ [ pkgs.bash ];

  extraInstallCommands = ''
    ln -s $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
    install -m 444 -D ${appimageContents}/${pname}.png \
      $out/share/icons/hicolor/512x512/apps/${pname}.png
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows";
    homepage = "https://www.beekeeperstudio.io";
    changelog = "https://github.com/beekeeper-studio/ultimate-releases/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ milogert alexnortung ];
    platforms = [ "x86_64-linux" ];
  };
}
