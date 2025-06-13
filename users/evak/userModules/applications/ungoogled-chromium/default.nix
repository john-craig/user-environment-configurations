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
          # adguard
          id = "bgnkhhnnamicmpeenaelnjfhikgbkllg";
          sha256 = "sha256:1mxz316fd0z69x2s6bbzi9h4d0id49hgag8ip16y30pcmx2i8sc0";
          version = "5.0.178";
        })
        (createChromiumExtension {
          # adblock plus
          id = "cfhdojbkjhnklbpkdaibdccddilifddb";
          sha256 = "sha256:1jc6r4hvasri1vwyd08gr9rlfddvfl18nnc81x04fnyahp1gafy7";
          version = "4.22.1";
        })
        # (createChromiumExtension {
        #   # keepassxc
        #   id = "oboonakemofpalcgghocfoadofidjkkk";
        #   sha256 = "sha256:0bh1jcvjw0cprbk8fy6jbngzpc48cbvjlhbfl0ca20nzrgams2g7";
        #   version = "1.9.4";
        # })
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
        # (createChromiumExtension {
        #   # limiter
        #   id = "blcdfhbibkkjpfdddnmnmhfgjlicebba";
        #   sha256 = "sha256:0n3dx3bypdhslj9lixn2a6b80h6ygrk9ygy0c5g4ld9hb238i5y5";
        #   version = "1.0.3";
        # })
        (createChromiumExtension {
          # focusguard
          id = "ifdepgnnjpnbkcgempionjablajancjc";
          sha256 = "sha256:0mhw5mz04zfbddxx588bh844j84kcjv18bvwyak3r36qkxl54az0";
          version = "1.0.4";
        })
        (createChromiumExtension {
          # simplelogin
          id = "dphilobhebphkdjbpfohgikllaljmgbn";
          sha256 = "sha256:1sadbyydwl4bhqwsjpdwhar0f9azzak2rnvb8hyb9qvazy3bhd7g";
          version = "3.0.5";
        })
        (createChromiumExtension {
          # coinbase wallet
          id = "hnfanknocfeofbddgcijnmhnfnkdnaad";
          sha256 = "sha256:1g3bpgqx05qb53z13592cjkrkz1dnm2njrz0ispx3r0p321acwl3";
          version = "3.98.1";
        })
      ];
    commandLineArgs = [
      "--no-sandbox"
      "--ozone-platform=wayland"
      "--disable-gpu"
      "--force-dark-mode"
      "--restore-last-session"
    ];

  };
}
