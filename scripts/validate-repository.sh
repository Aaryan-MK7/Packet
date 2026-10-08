#!/usr/bin/env bash

set -eu

root="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
test -s "${root}/README.md"

if git -C "${root}" ls-files -z | xargs -0 grep -IlE \
  'BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY|mongodb(\+srv)?://[^[:space:]]+:[^[:space:]]+@|AWS_SECRET_ACCESS_KEY=' \
  -- 2>/dev/null; then
  printf '%s\n' 'Potential credential material found in tracked files.' >&2
  exit 1
fi

printf '%s\n' 'Packet repository validation passed.'
