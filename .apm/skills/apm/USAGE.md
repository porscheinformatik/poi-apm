# Using the APM Skill

The `apm` skill provides comprehensive guidance for two main workflows:

## Quick Reference by Task

### Need to author APM packages?

**Ask:** "Use the apm skill — I need to create/modify a [skill|prompt|instruction|agent]"

The skill will guide you through:

- Choosing the right primitive type
- Creating files in the correct `.apm/` location
- Following frontmatter and formatting rules
- Validating your work with appropriate commands

### Need to install or manage APM?

**Ask:** "Use the apm skill — I need to install APM" or "I need to update APM"

The skill will guide you through:

- Platform detection (macOS, Linux, Windows, WSL)
- Installation methods (quick install, package managers, manual, source)
- Custom installations (user-local, enterprise mirrors)
- Troubleshooting (permission issues, glibc compatibility, antivirus conflicts)

### Need to work with APM CLI commands?

**Ask:** "Use the apm skill — I need to [compile|install|audit|update|self-update]"

The skill references all major commands with:

- Synopsis and purpose
- Practical examples
- Common options and flags
- Workflow recommendations

## Skill Organization

The apm skill is split into three reference files for focused reading:

1. **authoring.md** — APM primitive authoring (skills, prompts, instructions, agents, hooks, MCP)
   - Source of truth
   - Primitive type selection
   - File structure and naming
   - Authoring contract
   - Validation loops

2. **installation-and-setup.md** — APM CLI installation and setup
   - Quick install methods
   - Package managers (brew, scoop, pip)
   - Manual binary installation
   - Custom install locations
   - Enterprise mirrors and air-gapped setup
   - Troubleshooting
   - Environment variables
   - Building from source

3. **cli-operations.md** — Core CLI commands and workflows
   - Version checking
   - Self-update (upgrade APM itself)
   - install (dependency management)
   - update (refresh dependencies)
   - compile (assemble context files)
   - audit (security and integrity)
   - Common workflows

## When to Use Each Reference

| Task                                      | Reference                                   |
| ----------------------------------------- | ------------------------------------------- |
| Author a new skill                        | authoring.md                                |
| Create an instruction file                | authoring.md                                |
| Install APM for the first time            | installation-and-setup.md                   |
| Update APM to a newer version             | cli-operations.md → self-update             |
| Resolve a permission error during install | installation-and-setup.md → troubleshooting |
| Compile instructions for multiple targets | cli-operations.md → compile                 |
| Audit your package for security issues    | cli-operations.md → audit                   |
| Configure enterprise mirrors              | installation-and-setup.md → enterprise      |

## Migration from `author-apm`

If you were using the old `author-apm` skill:

- **Same content:** All authoring guidance is preserved in `apm` skill → `authoring.md`
- **New capabilities:** The `apm` skill now includes installation and CLI operations
- **Unified workflow:** Use a single skill for both authoring and package management

## Examples

### Example 1: Creating a new skill

```
"I want to create a new APM skill for code review.
Use the apm skill to guide me through the process."
```

The apm skill will guide you to:

- Create `.apm/skills/code-review/`
- Write `SKILL.md` with proper frontmatter
- Follow naming conventions
- Validate with `apm compile`

### Example 2: Installing APM on a new machine

```
"I'm on macOS and need to install APM.
Use the apm skill to walk me through it."
```

The apm skill will guide you to:

- Run the quick install command
- Verify with `apm --version`
- Configure if needed

### Example 3: Deploying to multiple targets

```
"I need to compile my instructions for claude, copilot, and cursor.
Use the apm skill to show me the command and options."
```

The apm skill will reference `cli-operations.md` → `compile` section with examples like:

```bash
apm compile -t claude,copilot,cursor
```

## See Also

- **Authoring rules:** `.github/instructions/` or `.claude/rules/` for format-specific rules
- **Official APM docs:** https://microsoft.github.io/apm/
- **Installation guide:** https://microsoft.github.io/apm/getting-started/installation/
- **CLI reference:** https://microsoft.github.io/apm/reference/
