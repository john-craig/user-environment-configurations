{ config, pkgs, lib, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions =
      let
        createChromiumExtensionFor = browserVersion: { id, sha256, version }:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
              name = "${id}.crx";
              inherit sha256;
            };
            inherit version;
          };
        createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
      in
      [
        (createChromiumExtension {
          # ublock origin
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "sha256:0lj0b5a2vga9x8nr12f9ijv1n0f8zcyzml19bzvw722jb98mic88";
          version = "1.37.2";
        })
        (createChromiumExtension {
          # keepassxc
          id = "oboonakemofpalcgghocfoadofidjkkk";
          sha256 = "sha256:0bh1jcvjw0cprbk8fy6jbngzpc48cbvjlhbfl0ca20nzrgams2g7";
          version = "1.9.4";
        })
        (createChromiumExtension {
          # privacy.com
          id = "hmgpakheknboplhmlicfkkgjipfabmhp";
          sha256 = "sha256:07npn481ng7cqa48yn0b5xvqb41pnd731nnsvl2024ksjya1f7hj";
          version = "2.4.2";
        })
        (createChromiumExtension {
          # bitwarden
          id = "nngceckbapebfimnlniiiahkandclblb";
          sha256 = "sha256:0kxkjnac3h1vcjjn8x5c1dpplp3hk1wi1j53qa7h2yyf21yns92h";
          version = "2024.11.2";
        })
      ];
    commandLineArgs = [
      "--no-sandbox"
      "--ozone-platform=wayland"
      "--disable-gpu"
      "--force-dark-mode"
    ];

  };
}
