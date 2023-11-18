{ lib, fetchurl, appimageTools, pkgs }:

let
  pname = "minecraft-bedrock";
  version = "0.12.1-763";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/minecraft-linux/appimage-builder/releases/download/v0.12.1-763/Minecraft_Bedrock_Launcher-x86_64-v0.12.1.763.AppImage";
    name = "${pname}-${version}.AppImage";
    sha512 = "f2f985960c480d57deae33341cdf892a9e649febce46554df59dfa0bbee006b47452e76dac399a9ccde8f8082b279345ccc53778b365d33585c1064f0a558a14";
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