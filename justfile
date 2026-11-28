set shell := ["bash", "-euo", "pipefail", "-c"]

_default:
    @just --list --unsorted --list-heading '' --list-prefix='- '

# rebase local commits onto upstream, then update submodules
pull:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "→ fetching upstream"
    git fetch upstream
    echo "→ rebasing onto upstream/main"
    git rebase --autostash upstream/main
    echo "→ updating submodules"
    git submodule update --init --recursive
    echo "✓ pull complete, publish with: git push --force-with-lease origin main"

# init submodules and build
setup:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "→ updating submodules"
    git submodule update --init --recursive
    echo "→ building"
    cargo build
    echo "✓ setup complete"
