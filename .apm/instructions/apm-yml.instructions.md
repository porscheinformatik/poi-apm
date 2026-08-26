---
description: Rules for authoring APM package manifests in apm.yml.
applyTo: "**/apm.yml"
---

- Keep the document a YAML mapping. Set non-empty `name` and quoted semantic-version `version` values; use conventional package identifiers and supply `description`, `author`, and an SPDX `license` for publishable packages.
- Prefer canonical plural `targets:` as a YAML list of supported target slugs. Do not declare both `target:` and `targets:`, use deprecated `all`, or use unknown targets. Pin targets when generated output or MCP ownership must be deterministic across developers and CI.
- Set `includes: auto` for explicit publication consent, or use an explicit relative path allow-list for stricter package boundaries. Do not use an allow-list to select local integration behavior; it controls packing consent and package contents.
- Use `scripts:` only as a flat string-to-string map. Define `start` for a portable default `apm run` entry point, keep runtime binaries on `PATH`, and use `apm preview <name>` before executing an unfamiliar script.
- Keep `dependencies` and `devDependencies` as mappings with `apm`, `mcp`, and/or `lsp` lists; do not use a top-level dependency list. Put shipped runtime requirements in `dependencies` and development-only tools or tests in `devDependencies`. Both install locally, but dev dependencies are excluded from plugin packages.
- Prefer a tag or full commit SHA in a git dependency for reproducibility. Use object form when an alias, monorepo subpath, target/skill restriction, custom host type, registry package, marketplace package, or local path is required. Use `ref` for git branches, tags, commits, or semver ranges; reserve `version` for registry and marketplace dependencies.

  ```yaml
  dependencies:
  	apm:
  		- owner/package#v1.2.0 # GitHub repository pinned to a tag
  		- owner/package#a1b2c3d4e5f6 # GitHub repository pinned to a commit
  		- owner/prompt-library/prompts/review.prompt.md # One virtual primitive file
  		- owner/agent-library/skills/security-review # One virtual subdirectory
  		- https://gitlab.example.com/platform/standards.git # HTTPS Git repository
  		- git@gitlab.example.com:platform/standards.git # SSH Git repository
  		- git: http://git.example.com/platform/legacy.git # HTTP requires explicit approval
  			allow_insecure: true
  			ref: v2.0.0
  		- git: https://github.com/owner/monorepo.git # Object form for subpaths and aliases
  			path: packages/review-rules
  			ref: v3.1.0
  			alias: review-rules
  		- path: ./packages/local-rules # Local resource relative to this manifest
  		- path: ../shared-apm-package # Sibling local package
  ```

- Use `type: gitlab` only for a self-managed GitLab host that hostname detection cannot identify. Keep remote-package `path` values inside the resolved repository; do not use absolute paths, repository-escaping paths, or cross-repository local paths.
- Declare MCP servers under `dependencies.mcp`. For self-defined servers, set `registry: false`, a valid `transport`, and exactly the required endpoint form: `command` plus `args` for `stdio`, or `url` for `http`, `sse`, or `streamable-http`. Use `${VAR}` or `${env:VAR}` in headers and environment values; never commit secret values. Treat MCP passthrough keys as cross-target settings, not harness-specific configuration.
- Declare LSP servers under `dependencies.lsp`. Object-form entries require `name`, `command`, and non-empty `extensionToLanguage`; use the documented camelCase keys rather than legacy snake_case aliases.
- Enable the `registries` experimental feature before adding `registries:` or registry dependencies. Give each registry a valid URL and use a distinct name that cannot collide after environment-variable normalization. Never store registry credentials in this manifest. A default registry reroutes shorthand `owner/repo#selector` dependencies, so use explicit `git:` objects for dependencies that must remain Git-sourced.
- Use `compilation:` only to control output placement or preservation. Prefer `strategy: distributed`; use `agents_md.mode: managed_section` only when the root `AGENTS.md` has exactly one pair of APM markers that must be preserved.
- Add `marketplace:` only when publishing a marketplace. Keep its metadata consistent with the top-level package identity, provide an owner, and give each remote package a `version` or `ref`; use the in-manifest form rather than a legacy standalone marketplace file.
- Treat `lifecycle:` as executable project configuration. Use only documented install, update, and uninstall events; keep webhooks HTTPS, source credentials from allowed environment variables, and require review plus `apm lifecycle trust` before enabling committed lifecycle changes.
- After editing this manifest, run `apm install` to resolve dependencies, update `apm.lock.yaml`, and deploy primitives. Delete removed dependencies, then run `apm prune --dry-run` before `apm prune`. Treat the lockfile and deployed target files as generated output: commit the lockfile, never edit it by hand, use `apm install --frozen` and `apm audit --ci` in CI, and rerun install or compile to refresh generated files.
