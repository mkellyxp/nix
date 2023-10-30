{ lib, fetchurl, appimageTools, pkgs }:

let
  pname = "beekeeper-studio";
  version = "4.0.2";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/beekeeper-studio/ultimate-releases/releases/download/v${version}/Beekeeper-Studio-Ultimate-${version}.AppImage";
    name = "${pname}-${version}.AppImage";
    sha512 = "005a91eadc6943fb05f6e4e342db0249dd5a302f02d717b064cb6052ab096cf87309a308d7a3c626123792a3c584dc8c7fb7dd214765993ff5ac15a22c5b6740";
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