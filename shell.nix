{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    haskell.compiler.ghc984
    cabal-install

    zlib
    hlint
    haskell-language-server
    ghcid
  ];

  shellHook = ''
    echo "Entering Haskell development environment"
    echo "GHC version: $(ghc --version)"
    echo "Cabal version: $(cabal --version)"
    echo ""
    echo "Available commands:"
    echo "  cabal build        - Build the project"
    echo "  cabal run          - Run the executable"
    echo "  cabal test         - Run tests"
    echo "  ghcid              - Start continuous compilation"
    echo ""
  '';
}
