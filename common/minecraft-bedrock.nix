{ lib, fetchurl, appimageTools, pkgs }:

let
  pname = "minecraft-bedrock";
  version = "0.11.2.718";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/minecraft-linux/appimage-builder/releases/download/v0.11.2-718/Minecraft_Bedrock_Launcher-x86_64-v0.11.2.718.AppImage";
    name = "${pname}-${version}.AppImage";
    sha512 = "fdfe63b004a2bd46ba904ff7bdde666637b7c1290ca4c60d1b88123448eb1f6b8896e2389eaecaefad961bdd689a4361b94036fae6a25ca07cadfbaa4878bb5e";
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
    install -m 444 -D ${appimageContents}/mcpelauncher-ui-qt.desktop $out/share/applications/${pname}.desktop
    install -m 444 -D ${appimageContents}/mcpelauncher-ui-qt.svg \
      $out/share/icons/hicolor/512x512/apps/${pname}.svg
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=mcpelauncher-ui-qt' 'Exec=${pname}'
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Icon=mcpelauncher-ui-qt' 'Icon=${pname}'
  '';

  meta = with lib; {
    description = "An unstable unofficial launcher for the Android version of Minecraft: Bedrock Edition on linux and macOS.";
    homepage = "https://www.beekeeperstudio.io";
    changelog = "https://github.com/minecraft-linux/appimage-builder/releases";
    license = licenses.mit;
    maintainers = with maintainers; [ mkelly ];
    platforms = [ "x86_64-linux" ];
  };
}