#!/bin/ash
set -e
for D in $(find charts -not -path '*/.*' -mindepth 1 -maxdepth 1 -type d)
do
  helm dependency update $D
  helm unittest $D
  helm template $D --dry-run
done
