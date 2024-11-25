final: prev:
{
  dismas = prev.dismas.overrideAttrs (old: {
    src = builtins.fetchGit {
        url = "file:///home/evak/programming/by_category/productivity/dismas";
    };
  });
}