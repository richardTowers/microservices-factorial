#!/usr/bin/env bash
set -ueo pipefail

apps=(
  # crystal
  # dotnet_core
  # go
  # haskell
  # java
  # nodejs
  # php
  # python
  ruby
  staticfile
)

for app1 in "${apps[@]}"; do
  for app2 in "${apps[@]}"; do
    app1_name="${app1}_factorial"
    app2_name="${app2}_factorial"

    cf add-network-policy "$app1_name" \
         --destination-app "${app2_name}" \
         --protocol tcp \
         --port 8080
  done
done

for app in "${apps[@]}"; do
  cf restart "${app}_factorial"
done
