final: prev:
{
  panmuphle = prev.panmuphle.overrideAttrs (old: {
    src = builtins.fetchGit {
        url = "file:///home/evak/programming/by_category/desktop_environment/panmuphle";
    };
  });
}