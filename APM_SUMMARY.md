# APM Summary

## Agents

### apm-expert

- **Filename:** `apm_modules/microsoft/apm/packages/apm-guide/.apm/agents/apm-expert.agent.md`
- **Command:** `@apm-expert`
- **Dependency:** `microsoft/apm/packages/apm-guide`

Expert on APM that helps install, configure, author, and troubleshoot APM packages, dependencies, compilation, MCP servers, and governance policies.

## Instructions

### APM Agents Instructions

- **Filename:** `.apm/instructions/apm-agents.instructions.md`
- **Apply To:** `**/.apm/agents/*.agent.md`

This instruction is used to define how APM agent files are authored, scoped, and validated so personas stay concise, role-focused, and portable across targets.

### APM Instructions Instructions

- **Filename:** `.apm/instructions/apm-instructions.instructions.md`
- **Apply To:** `**/.apm/instructions/*.instructions.md`

This instruction is used to define always-on instruction policy, including required frontmatter, applyTo behavior, topic scoping, and validation expectations.

### APM Prompts Instructions

- **Filename:** `.apm/instructions/apm-prompts.instructions.md`
- **Apply To:** `**/.apm/prompts/*.prompt.md`

This instruction standardizes authoring of legacy APM prompt files (no longer supported; new on-demand workflows are skills). It covers one intent per file, preserved frontmatter keys, and deterministic body flow.

### APM Skills Instructions

- **Filename:** `.apm/instructions/apm-skills.instructions.md`
- **Apply To:** `**/.apm/skills/**/*`

This instruction is used to define APM skill structure, naming, frontmatter, and concise operational content so runtime matching and cross-target deployment stay reliable.

### APM Yml Instructions

- **Filename:** `.apm/instructions/apm-yml.instructions.md`
- **Apply To:** `**/apm.yml`

This instruction defines authoring rules for `apm.yml` manifests: metadata, targets, includes, dependencies, MCP and LSP servers, compilation, and validation.

## Prompts

No prompt files remain; former prompts were migrated to explicit-only skills (see Skills). `.apm/prompts/` contains only `AGENTS.md`.

## Skills

### apm-agent

- **Filename:** `.apm/skills/apm-agent/SKILL.md`
- **Command:** `/apm-agent` (explicit only; `disable-model-invocation: true`)
- **Inputs:** `source_mode`, `task_instructions`, `target_agent`, `step_list`, `tool_preferences`, `include_review_phase`

Creates or updates an APM agent from requirements and execution steps, enforcing agent path and suffix rules, frontmatter and body conventions, and OpenCode compatibility for tools and color.

### apm-authoring

- **Filename:** `.apm/skills/apm-authoring/SKILL.md`
- **When:** `Use when creating, modifying, reviewing, or optimizing APM skills, prompts, instructions, agents, hooks, or producer-side package configuration. Focus on primitive selection, concise content, and cross-target authoring correctness.`

Used when authoring and reviewing APM primitives and producer-side package configuration. It covers primitive selection, concise content, target-specific constraints, and validation of installed output. General CLI and consumer workflows are delegated to the `apm-usage` skill.

### apm-instructions

- **Filename:** `.apm/skills/apm-instructions/SKILL.md`
- **Command:** `/apm-instructions` (explicit only; `disable-model-invocation: true`)
- **Inputs:** `source_mode`, `task_instructions`, `source_files`, `target_instructions`, `search_similar`, `similar_include_pattern`

Creates or updates a single instructions file from selected sources, enforcing one-domain scope, extracting only shared rules, and validating structure.

### apm-migrate-prompt-to-skill

- **Filename:** `.apm/skills/apm-migrate-prompt-to-skill/SKILL.md`
- **Command:** `/apm-migrate-prompt-to-skill` (explicit only; `disable-model-invocation: true`)
- **Inputs:** `target_prompts`, `skill_invocation`

Migrates `.apm/prompts/*.prompt.md` files to `.apm/skills/<name>/SKILL.md` by editing frontmatter only (adds `name` and, by default, `disable-model-invocation: true`), updating `apm.yml` includes and references, and validating with audit, compile, and an install dry run. Prompt files are no longer supported.

### apm-skill

- **Filename:** `.apm/skills/apm-skill/SKILL.md`
- **Command:** `/apm-skill` (explicit only; `disable-model-invocation: true`)
- **Inputs:** `source_mode`, `source_urls`, `source_docs`, `source_paths`, `task_instructions`, `target_skill`, `extends_skill`, `allow_web_fetch`

Creates or updates an APM skill from documentation, code references, or chat, including explicit-only workflows formerly authored as prompts. Decides invocation mode (asking the user when unclear), enforces skill path and structure rules, and validates trigger-oriented descriptions.

### apm-summary

- **Filename:** `.apm/skills/apm-summary/SKILL.md`
- **Command:** `/apm-summary` (explicit only; `disable-model-invocation: true`)

Creates or updates `APM_SUMMARY.md` by scanning in-scope `.apm` sources and dependencies, applying section formatting and sorting rules, and verifying coverage before finalizing.

### apm-usage

- **Filename:** `apm_modules/microsoft/apm/packages/apm-guide/.apm/skills/apm-usage/SKILL.md`
- **When:** `Activate when the user asks about APM (Agent Package Manager): installing, configuring, authoring, or troubleshooting AI-agent packages, dependencies, compilation, MCP servers, policy, or any apm CLI command.`
- **Dependency:** `microsoft/apm/packages/apm-guide`

Reference guidance for the `apm` CLI: installation, authentication, commands, dependencies, governance, package authoring, troubleshooting, and workflow.

### optimize-apm

- **Filename:** `.apm/skills/optimize-apm/SKILL.md`
- **Command:** `/optimize-apm` (explicit only; `disable-model-invocation: true`)

Optimizes `.apm` files for concision, validity, and portability by applying the matching authoring instructions, preserving behavior, and reporting targeted improvements.

### review-apm

- **Filename:** `.apm/skills/review-apm/SKILL.md`
- **Command:** `/review-apm` (explicit only; `disable-model-invocation: true`)

Reviews a selected `.apm` file for structure, validity, and cross-target portability, applying type-specific rules and summarizing findings by severity.

### setup-apm

- **Filename:** `.apm/skills/setup-apm/SKILL.md`
- **Command:** `/setup-apm` (explicit only; `disable-model-invocation: true`)
- **Inputs:** `operation`, `install_method`, `target_version`, `install_scope`, `verify_after_action`

Installs or repairs APM, verifies installation status, and updates APM to a requested version, validating inputs, selecting platform-safe install paths, and verifying after the action.

## Hooks

No hooks are defined.

## MCPs

No MCP servers are declared in `apm.yml` (`dependencies.mcp: []`).

## Dependencies

### microsoft/apm/packages/apm-guide

- **Type:** runtime (`dependencies.apm`)
- **Resolved:** `apm-guide` 1.0.0 at commit `1a6c1df655b7a14272fa4506a0ceaf5dc5644fb3` (verified in `apm.lock.yaml` and `apm_modules/`)

Provides the `apm-usage` skill and the `apm-expert` agent, listed above.
