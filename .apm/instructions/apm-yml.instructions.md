---
description: Rules for authoring APM package manifests in apm.yml.
applyTo: "**/apm.yml"
---

- Keep the document a YAML mapping. Set non-empty `name` and quoted semantic-version `version` values; use conventional package identifiers and supply `description`, `author`, and an SPDX `license` for publishable packages.
- Use spaces, never tabs, for YAML indentation, including embedded examples. Distinguish authoring conventions from parser requirements: publication metadata is recommended, while `name` and string `version` are required.
- Preserve unknown top-level fields when editing existing manifests. Use `x-<name>` for intentional vendor extensions; other unknown keys may warn and be ignored by the CLI. Add `$schema` only for a published contract recognized by the installed CLI; omission selects its working draft and unknown identities fail closed.
- Prefer canonical plural `targets:` as a YAML list of supported target slugs. Do not declare both `target:` and `targets:`, use deprecated `all`, or use unknown targets. Pin targets when generated output or MCP ownership must be deterministic across developers and CI.
- Set `includes: auto` for explicit publication consent, or use an explicit relative path allow-list for stricter package boundaries. The list is exhaustive for plugin packing but does not filter install-time primitive discovery. Policies requiring explicit path lists do not accept `auto`; do not use it to bypass those policies.
- Use `scripts:` only as a flat string-to-string map. Define `start` when the package offers a default `apm run` workflow; do not invent executable scripts for context-only packages. Keep runtime binaries on `PATH` and use `apm preview <name>` before executing an unfamiliar script.
- Keep `dependencies` and `devDependencies` as mappings with `apm`, `mcp`, and/or `lsp` lists; do not use a top-level dependency list. Put shipped runtime requirements in `dependencies` and development-only tools or tests in `devDependencies`. Both install locally, but dev dependencies are excluded from plugin packages.
- Prefer a tag or full commit SHA in a git dependency for reproducibility. Use object form when an alias, monorepo subpath, target/skill restriction, custom host type, registry package, marketplace package, or local path is required. Use `ref` for git branches, tags, commits, or semver ranges; reserve `version` for registry and marketplace dependencies.

  ```yaml
  dependencies:
    apm:
      - owner/package#v1.2.0
      - owner/prompt-library/prompts/review.prompt.md
      - git: https://github.com/owner/monorepo.git
        path: packages/review-rules
        ref: v3.1.0
        alias: review-rules
      - path: ./packages/local-rules
      - path: ../shared-apm-package
  ```

- Use `type: gitlab` only for a self-managed GitLab host that hostname detection cannot identify. Keep remote-package `path` values inside the resolved repository; do not use absolute paths, repository-escaping paths, or cross-repository local paths.
- Use HTTPS for Git dependencies. HTTP requires manifest-side `allow_insecure: true` and a separate install-time opt-in; do not silently weaken transport security. Dependency `targets:` and `skills:` restrict reach and selection rather than activating additional harnesses.
- Declare consumer MCP servers under `dependencies.mcp`, and author-only servers under `devDependencies.mcp`. For self-defined servers, require `name`, `registry: false`, and a valid `transport`: `command` for `stdio`, or an HTTP(S) `url` for `http`, `sse`, or `streamable-http`. Put command-line arguments in the optional `args` list; if a binary path contains spaces, supply `args` explicitly, including `[]` when empty.
- Use `${VAR}` or `${env:VAR}` in MCP headers and environment values; never commit secret values. Resolution is target-specific: some targets retain runtime references, while literal-only targets may resolve values during installation. Review generated configuration before committing it. `${input:<id>}` is VS Code-specific; GitHub Actions expressions are not evaluated by APM.
- MCP passthrough keys may be harness-specific but are broadcast to every installed target, with warnings for non-standard keys; do not assume per-harness scoping. Reserved fields cannot be overridden through passthrough. `enabled` is forwarded only to OpenCode. Inspect native configuration and document unsupported behavior rather than treating passthrough as universally portable.
- Declare LSP servers under `dependencies.lsp`. Object-form entries require `name`, `command`, and non-empty `extensionToLanguage`; use the documented camelCase keys rather than legacy snake_case aliases.
- Enable the `registries` experimental feature before adding `registries:` or registry dependencies. Give each registry a valid URL and use a distinct name that cannot collide after environment-variable normalization. Never store registry credentials in this manifest. A default registry reroutes shorthand `owner/repo#selector` dependencies, so use explicit `git:` objects for dependencies that must remain Git-sourced.
- Use `compilation:` for documented compilation behavior, such as strategy, placement, exclusions, link resolution, attribution, and preservation. Prefer `strategy: distributed`. In `agents_md.mode: managed_section`, every existing managed target file must have exactly one matching marker pair, not just the root file; new distributed placements get a managed block. Preview placements before changing this mode, and preserve hand-authored content.
- Add `marketplace:` only when publishing a marketplace. Keep its metadata consistent with the top-level package identity, provide an owner, and give each remote package a `version` or `ref`; use the in-manifest form rather than a legacy standalone marketplace file.
- Treat `lifecycle:` as executable project configuration. Use only documented install, update, and uninstall events; keep webhooks HTTPS, source credentials from allowed environment variables, and require review plus `apm lifecycle trust` before enabling committed lifecycle changes.
- After a manifest change, preview `apm install --dry-run`, then run `apm install` to reconcile dependencies and generated output. Remove dependency declarations from the manifest rather than deleting cached sources by hand; inspect `apm prune --dry-run` before approving cleanup. Commit the generated lockfile, never edit it manually, and use `apm install --frozen` and `apm audit --ci` in CI. Report unavailable policy verification instead of claiming enforcement or bypassing it.
- Validate embedded YAML examples with a YAML parser. Use `apm pack --dry-run --verbose` to verify publication boundaries when packaging configuration changes; compile validation alone does not prove manifest resolution, resource completeness, or runtime behavior.
