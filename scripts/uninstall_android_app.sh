#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
app_gradle_kts="$project_root/android/app/build.gradle.kts"
app_gradle="$project_root/android/app/build.gradle"

resolve_app_id() {
  local gradle_file="$1"
  if [[ -f "$gradle_file" ]]; then
    rg -m 1 -o 'applicationId\s*=\s*"[^"]+"' "$gradle_file" \
      | sed -E 's/applicationId\s*=\s*"(.*)"/\1/'
  fi
}

app_id=""
app_id="$(resolve_app_id "$app_gradle_kts")"
if [[ -z "$app_id" ]]; then
  app_id="$(resolve_app_id "$app_gradle")"
fi

if [[ -z "$app_id" ]]; then
  echo "Failed to resolve applicationId from: $app_gradle_kts or $app_gradle" >&2
  exit 1
fi

if ! command -v adb >/dev/null 2>&1; then
  echo "adb not found in PATH. Please install Android platform-tools." >&2
  exit 1
fi

echo "Application ID: $app_id"
if adb uninstall "$app_id"; then
  echo "Uninstall result: success"
else
  echo "Uninstall result: failed" >&2
  exit 1
fi
