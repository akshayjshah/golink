#!/bin/sh
set -euo pipefail

VERSION=$(git describe --always --tags --dirty 2>/dev/null)

demo() {
    rm -f ./golink
    go clean -cache
    echo "-ldflags=${SCOPE}"
    go build -ldflags=${SCOPE}="-X github.com/akshayjshah/golink/vendor/github.com/akshayjshah/version.Version=${VERSION}" github.com/akshayjshah/golink
    ./golink
    echo ""
    rm golink
}

echo "=== Working but inefficient approaches ==="
echo "=========================================="


SCOPE="all"
echo "This works, but rebuilds the world."
demo

SCOPE="github.com/akshayjshah/golink/..."
echo "This avoids rebuilding the stdlib, but still rebuilds all of this project's code."
demo

echo "=== Attempts to scope flags to a single package, none of which work ==="
echo "======================================================================="

SCOPE="github.com/akshayjshah/golink/vendor/github.com/akshayjshah/version"
demo

SCOPE="github.com/akshayjshah/version"
demo

SCOPE="github.com/akshayjshah/golink/vendor/..."
demo
