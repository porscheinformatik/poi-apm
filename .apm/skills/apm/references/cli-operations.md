# APM CLI Core Operations

Use this section when working with APM's main CLI commands: `compile`, `install`, `update`, `audit`, and `self-update`.

## Quick navigation

- **Version management**: Check version, available updates
- **Self-update**: Upgrade APM itself, manage channels and versions
- **install**: Resolve and deploy dependencies, target selection, MCP servers
- **update**: Refresh dependencies to latest versions
- **compile**: Assemble context files, target-specific output, validation
- **audit**: Security scanning, CI gate checks, policy validation
- **Common workflows**: Full setup, CI pipelines, global installation, watch mode

## Version management

### Check the current version

```bash
apm --version
```

### Check for available updates

```bash
apm self-update --check
```

## Self-update (upgrade APM itself)

The `apm self-update` command upgrades the APM CLI binary to the latest version published on GitHub releases.

### Install the latest version

```bash
apm self-update
```

### Override the install directory

```bash
apm config set self-update.install-dir ~/.local/bin
apm self-update
```

Or via environment variable:

```bash
APM_INSTALL_DIR=$HOME/.local/bin apm self-update
```

### Use prerelease versions

```bash
apm config set self-update.channel prerelease
apm self-update
```

Or temporarily:

```bash
APM_SELF_UPDATE_CHANNEL=prerelease apm self-update
```

### Rollback to a specific version

```bash
# macOS/Linux
curl -sSL https://aka.ms/apm-unix | VERSION=v0.19.0 sh

# Windows (PowerShell)
$env:VERSION = "v0.19.0"; irm https://aka.ms/apm-windows | iex
```

### Enterprise mirrors for self-update

Use the same mirror variables as installation:

```bash
export APM_RELEASE_METADATA_URL="https://mirror.example/apm-releases/latest.json"
export APM_INSTALLER_BASE_URL="https://mirror.example/apm-install"
export APM_RELEASE_BASE_URL="https://mirror.example/apm-releases"
apm self-update --check
apm self-update
```

## install (dependency management)

The `apm install` command resolves and deploys APM packages and MCP servers.

### Install everything from apm.yml

```bash
apm install
```

### Add and install a specific package

```bash
apm install microsoft/apm-sample-package
apm install https://gitlab.com/acme/coding-standards.git
apm install code-review@acme-plugins#v2.0.0
```

### Install only an MCP server

```bash
# Stdio server via command args
apm install --mcp filesystem -- npx -y @modelcontextprotocol/server-filesystem /workspace

# Registry entry
apm install --mcp io.github.github/github-mcp-server

# Remote HTTP server
apm install --mcp my-api --url https://mcp.example.com --header "Authorization=Bearer ${API_TOKEN}"
```

### Pick specific targets

```bash
apm install --target claude,cursor
apm install --target all,agent-skills
apm install --exclude codex
```

### Install to a custom root directory

Resolve from current directory, but write to another:

```bash
apm install --root /tmp/apm-out --target copilot
ls /tmp/apm-out  # apm_modules/, apm.lock.yaml, .github/, .gitignore
```

### Frozen mode (read-only, lockfile-only)

Refuse to resolve anything new; fail if lockfile is missing or stale:

```bash
apm install --frozen
```

Ideal for CI pipelines where reproducibility is critical.

### Dry-run (preview without writing)

```bash
apm install --dry-run
apm install microsoft/apm-sample-package --dry-run
```

### Global installation (user-scope)

Install to `~/.apm/` instead of the current project:

```bash
apm install -g microsoft/apm-sample-package
```

MCP servers deploy globally by default; packages require target-specific harness support.

### Install a subset of skills from a bundle

```bash
apm install owner/skill-bundle --skill review
apm install owner/skill-bundle --skill refactor     # adds refactor; review is kept (union)
apm install owner/skill-bundle --skill '*'          # reset to all skills
```

### Install options summary

| Option                       | Purpose                                                         |
| ---------------------------- | --------------------------------------------------------------- |
| `--update`                   | Re-resolve dependencies to latest versions                      |
| `--frozen`                   | Lockfile-only install; fail if anything is missing              |
| `--dry-run`                  | Preview without writing                                         |
| `--force`                    | Overwrite collisions and bypass security scan critical findings |
| `--verbose, -v`              | Show per-file paths and error detail                            |
| `--dev`                      | Add new packages to devDependencies                             |
| `--target, -t VALUE`         | Force deployment targets (comma-separated)                      |
| `--global, -g`               | Install to user scope (~/.apm/)                                 |
| `--skill NAME`               | Install only named skill(s) from a bundle (repeatable)          |
| `--parallel-downloads N`     | Max concurrent downloads (default: 4)                           |
| `--refresh`                  | Bypass cache and re-fetch every dependency                      |
| `--audit <off\|warn\|block>` | Content scan audit behavior                                     |
| `--no-audit`                 | Disable install-time audit                                      |

## update (refresh dependencies)

The `apm update` command re-resolves dependencies in `apm.yml` to their latest matching versions or Git refs.

### Update all dependencies

```bash
apm update
```

### Update with frozen lockfile (CI-safe)

Update manifest only, but verify against lockfile:

```bash
apm update --frozen
```

This updates `apm.yml` without re-resolving, ensuring CI gates catch drift.

## compile (assemble context files)

The `apm compile` command reads instructions from `.apm/` and `apm_modules/`, then writes root context files and per-target rules.

### Compile for current project targets (auto-detect)

```bash
apm compile
```

### Compile for specific targets

```bash
apm compile --target claude
apm compile --target copilot
apm compile -t claude,copilot
```

### Compile for all targets

```bash
apm compile --all
```

### Validate without writing

```bash
apm compile --validate
```

### Preview placement without writing

```bash
apm compile --dry-run
apm compile -t claude,codex --dry-run -v
```

### Watch mode (auto-recompile on changes)

```bash
apm compile --watch
```

Monitor `.apm/`, `.github/instructions/`, `.github/agents/` for changes and re-run automatically.

### Skip dependencies and compile local only

```bash
apm compile --local-only
```

### Remove stale AGENTS.md files

```bash
apm compile --clean
apm compile --clean --dry-run --target claude
```

### Global compilation (user-scope)

```bash
apm compile -g
```

Compile user-scope root context files from `~/.apm/apm_modules/` and write to targets like `~/.claude/CLAUDE.md`.

## audit (security and integrity)

The `apm audit` command scans for hidden Unicode, detects drift, and runs CI gate checks.

### Default audit (content scan plus drift)

```bash
apm audit
```

Scans deployed files for hidden Unicode and detects hand-edits or missing integrations.

### Scan a specific installed package

```bash
apm audit https://github.com/owner/repo
```

### Scan an arbitrary file

```bash
apm audit --file .cursorrules
```

### Remediate findings (remove hidden Unicode)

```bash
# Preview what --strip would remove
apm audit --strip --dry-run

# Strip critical and warning characters in place
apm audit --strip
```

### CI gate mode

```bash
apm audit --ci
```

Run lockfile consistency checks and drift detection with machine-readable exit codes.

### Output formats

```bash
# SARIF to stdout (for GitHub Code Scanning)
apm audit -f sarif

# JSON to a file
apm audit -f json -o results.json

# Markdown for GitHub Actions step summary
apm audit -f markdown -o "$GITHUB_STEP_SUMMARY"

# Auto-detect format from extension
apm audit -o report.sarif
```

### CI gate with policy checks

```bash
# Default (auto-discover org policy)
apm audit --ci

# Baseline checks only (no policy)
apm audit --ci --no-policy

# Explicit policy source
apm audit --ci --policy org
apm audit --ci --policy ./apm-policy.yml

# Full diagnostic (don't stop at first failure)
apm audit --ci --no-fail-fast

# CI gate as JSON or SARIF
apm audit --ci -f json
apm audit --ci -f sarif -o audit.sarif
```

## Common workflows

### Full project setup workflow

```bash
# 1. Install APM itself (once per machine)
curl -sSL https://aka.ms/apm-unix | sh

# 2. Verify installation
apm --version

# 3. Initialize a new project
apm init

# 4. Install dependencies
apm install

# 5. Compile instructions
apm compile --all

# 6. Audit before shipping
apm audit
```

### Dependency refresh in CI

```bash
# Update dependencies to latest allowed versions
apm update

# Reinstall with updated lockfile
apm install --frozen --parallel-downloads 8

# Run security gate
apm audit --ci --no-policy
```

### Global skill installation

```bash
# Install to user scope
apm install -g microsoft/apm-sample-skills

# Compile global instructions
apm compile -g

# Target-specific (e.g., Claude)
apm compile -g --target claude
```

### Watch mode for tight authoring

```bash
# Auto-recompile and validate on every change
apm compile --watch --dry-run --validate
```

Press Ctrl+C to stop.
