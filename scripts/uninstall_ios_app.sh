#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
pbxproj="$project_root/ios/Runner.xcodeproj/project.pbxproj"

if [[ ! -f "$pbxproj" ]]; then
  echo "iOS project file not found: $pbxproj" >&2
  exit 1
fi

bundle_id=$(
  rg -m 1 -o "PRODUCT_BUNDLE_IDENTIFIER = [^;]+" "$pbxproj" \
    | sed 's/PRODUCT_BUNDLE_IDENTIFIER = //'
)

if [[ -z "$bundle_id" ]]; then
  echo "Failed to resolve PRODUCT_BUNDLE_IDENTIFIER from: $pbxproj" >&2
  exit 1
fi

echo "Bundle ID: $bundle_id"
if xcrun simctl uninstall booted "$bundle_id"; then
  echo "Uninstall result: success"
else
  echo "Uninstall result: failed" >&2
  exit 1
fi
