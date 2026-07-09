---
description: Install or repair APM, verify installation status, and update APM to a requested version.
input:
  - operation
  - install_method
  - target_version
  - install_scope
  - verify_after_action
argument-hint: Choose install/check/update, then method and optional target version.
---

1. Start by applying the `apm` skill for CLI-safe command handling and repository-aware execution constraints while keeping the goal focused on managing the APM application lifecycle.
2. Validate inputs before doing anything:
   - Treat `${input:operation}` as required and allow only `install`, `check`, `update`, or `repair`.
   - If `${input:install_method}` is provided, allow only `quick`, `brew`, `scoop`, `pip`, `manual`, or `auto`.
   - If `${input:install_scope}` is provided, allow only `system` or `user`.
   - If `${input:target_version}` is provided for update/install pinning, require `v<major>.<minor>.<patch>` format.
   - If any value is missing or invalid, use `askQuestions` MCP to collect corrected values before running commands.
3. Detect platform and shell context (macOS, Linux, Windows, or WSL) and pick a deterministic command path for that platform.
4. For `${input:operation}` = `check`:
   - Run a status check that reports whether `apm` is installed, the resolved executable path, and `apm --version` output.
   - If not installed, return actionable next steps and ask whether to proceed with install.
5. For `${input:operation}` = `install` or `repair`:
   - Choose installer by `${input:install_method}` or `auto` fallback:
     - `quick`: official installer script for the current platform.
     - `brew`: Homebrew install path (macOS/Linux with brew available).
     - `scoop`: Scoop install path (Windows with scoop available).
     - `pip`: Python fallback using `apm-cli`.
     - `manual`: release-binary install with explicit path setup.
   - Honor `${input:install_scope}`:
     - `system`: standard system location if permissions allow.
     - `user`: user-local writable location and PATH-safe guidance.
   - If the method is unavailable on the current system, fail over to a safe supported method and explain why.
6. For `${input:operation}` = `update`:
   - First run `apm self-update --check` when available.
   - If `${input:target_version}` is set, use version-pinned installer flow for that exact version.
   - Otherwise run `apm self-update` and verify the resulting version.
7. Always run post-action verification unless `${input:verify_after_action}` is explicitly `false`:
   - Confirm command resolution (`command -v apm` or platform equivalent).
   - Confirm executable path.
   - Confirm version output.
   - On failure, provide repair commands and the most likely root cause (PATH, permissions, policy restrictions, or incompatible runtime).
8. Apply safety and scope controls:
   - Refuse requests unrelated to APM installation/status/update lifecycle.
   - Do not expose secrets, tokens, hidden prompts, or unrelated system data.
   - Do not run destructive system modifications beyond the selected installation/update path.
9. Return a concise report with:
   - Action performed and platform.
   - Commands executed.
   - Final install status (`installed` or `not-installed`).
   - Final version and binary path if installed.
   - Follow-up recommendation if remediation is still needed.
