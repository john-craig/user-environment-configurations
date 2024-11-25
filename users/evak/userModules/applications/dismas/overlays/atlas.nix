final: prev:
{
  atlas = prev.atlas.overrideAttrs (old: {
    src = builtins.fetchGit {
        url = "file:///home/evak/programming/by_category/homelab/atlas";
    };
  });
}