{ lib, fetchurl, appimageTools, pkgs }:

let
  pname = "minecraft-bedrock";
  version = "0.9.0.713";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/minecraft-linux/appimage-builder/releases/download/v0.9.0-713/Minecraft_Bedrock_Launcher-x86_64-v0.9.0.713.AppImage";
    name = "${pname}-${version}.AppImage";
    sha512 = "1a69dd3556d10ca6aa27fe11c7e146945e27206049439f15bd2e7711941bccdd4f50b6a90be2b96e5e26434f3d2d0eee186807796cbab84abfddccca0eac3d13";
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };
in
appimageTools.wrapType2 {
  inherit name src;

  multiPkgs = null; # no 32bit needed
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