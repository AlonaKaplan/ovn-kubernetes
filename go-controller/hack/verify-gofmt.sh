#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

PKGS=${PKGS:-.}

find_files() {
  find ${PKGS} -not \( \
      \( \
        -wholename '*/vendor/*' \
        -o -wholename '*/_output/*' \
      \) -prune \
    \) -name '*.go'
}

GOFMT="gofmt -s"
bad_files=$(find_files | xargs $GOFMT -l)
if [[ -n "${bad_files}" ]]; then
    $GOFMT -w $bad_files
    echo "Following files were formatted:"
    echo "${bad_files}"
fi
