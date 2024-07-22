{ lib, fetchurl, appimageTools, pkgs }:

let
  pname = "beekeeper-studio";
  version = "4.6.4";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/beekeeper-studio/ultimate-releases/releases/download/v${version}/Beekeeper-Studio-Ultimate-${version}.AppImage";
    name = "${pname}-${version}.AppImage";
    sha512 = "791af99b01f28a749c253d8bd523d5225fde9eb5d49da842fbf4428c858630c89fd7221f59e5122a514de4bea64e9ab5f1c948b9722bcbc96b28a885723c0148";
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
