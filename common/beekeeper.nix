{ lib, fetchurl, appimageTools, pkgs }:

let
  pname = "beekeeper-studio";
  version = "4.1.13";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/beekeeper-studio/ultimate-releases/releases/download/v${version}/Beekeeper-Studio-Ultimate-${version}.AppImage";
    name = "${pname}-${version}.AppImage";
    sha512 = "df65ed37d112e8850758da6c123b6c03abb66cfd91a7af40fb9c8b0ddfe1cc8de5e9e5d063bd810d47104d7e9152dac86fd8a68f4ac597930ee09a59f32241b1";
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