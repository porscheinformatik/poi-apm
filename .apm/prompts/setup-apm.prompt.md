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

1. Load the `apm-usage` skill and its installation reference. Keep this workflow limited to the APM application lifecycle, not project dependency updates or package authoring. Use the current reference for commands instead of duplicating an installer manual.
2. Resolve `${input:operation}` from supplied input or unambiguous user intent: `install`, `check`, `update`, or `repair`. Validate optional `${input:install_method}` (`auto`, `quick`, `brew`, `winget`, `scoop`, `pip`, or `manual`), `${input:install_scope}` (`system` or `user`), `${input:target_version}` (`v<major>.<minor>.<patch>`), and boolean `${input:verify_after_action}`. Omitted method means `auto`; omitted verification means true. Ask only for required missing or invalid values using an available structured-question tool, with plain chat as a fallback.
3. Detect platform, shell, resolved APM binary, version, installation owner, and duplicate PATH entries. For `check`, report status without installing, repairing, updating, or changing shell configuration. Distinguish an unavailable command from an unverified or broken installation.
4. For installation or repair, honor the requested method and scope. Prefer an existing installation's owner; for fresh installations choose a supported method from the installation reference. Do not silently switch methods, replace package-manager-owned binaries, create shadow installations, or alter unrelated PATH entries. Ask before changing ownership, scope, or destination; report unsupported combinations rather than pretending to honor them.
5. For updates, use the owning manager: Homebrew, WinGet, Scoop, or the owning Python's `-m pip`. Use `apm self-update --check` and `apm self-update` only for standalone installations. If `${input:target_version}` is supplied, use that owner's supported pinning mechanism; if unavailable, explain the limitation and ask before migration. Never run a standalone installer over a package-manager-owned installation.
6. Keep integrity verification enabled, protect secrets, and avoid destructive repair. If elevated privileges or secret input are required, ask the user to perform that step directly rather than collecting credentials. Do not bypass organization policy or fall back to another installer after an integrity failure.
7. Unless `${input:verify_after_action}` is false, verify command resolution, binary path, version, and any requested exact version after a mutation. If verification is disabled or unavailable, report the final state as unverified; do not infer success from an installer exit alone.
8. Report the operation, platform, installation owner, commands executed, observed status, binary path, and version. Explain failures and actionable next steps without performing an unrequested lifecycle operation.
