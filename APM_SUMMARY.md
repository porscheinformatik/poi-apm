# APM Summary

## Agents

No agent files were found in `.apm/agents`.

## Instructions

### APM Agents Instructions

- **Filename:** `.apm/instructions/apm-agents.instructions.md`
- **Apply To:** `.apm/agents/*.agent.md`

This instruction is used to define how APM agent files are authored, scoped, and validated so personas stay concise, role-focused, and portable across targets.

### APM Instructions Instructions

- **Filename:** `.apm/instructions/apm-instructions.instructions.md`
- **Apply To:** `.apm/instructions/*.instructions.md`

This instruction is used to define always-on instruction policy, including required frontmatter, applyTo behavior, topic scoping, and validation expectations.

### APM Prompts Instructions

- **Filename:** `.apm/instructions/apm-prompts.instructions.md`
- **Apply To:** `.apm/prompts/*.prompt.md`

This instruction is used to standardize APM prompt authoring with one intent per file, preserved frontmatter keys, deterministic body flow, and concise action-oriented descriptions.

### APM Skills Instructions

- **Filename:** `.apm/instructions/apm-skills.instructions.md`
- **Apply To:** `.apm/skills/**/SKILL.md`

This instruction is used to define APM skill structure, naming, frontmatter, and concise operational content so runtime matching and cross-target deployment stay reliable.

## Prompts

### APM Agent Prompt

- **Filename:** `.apm/prompts/apm-agent.prompt.md`
- **Command:** `/apm-agent`
- **Inputs:** `source_mode`, `task_instructions`, `target_agent`, `step_list`, `tool_preferences`, `include_review_phase`

This prompt creates or updates an APM agent from requirements by enforcing agent path and suffix rules, applying agent frontmatter and body conventions, and validating OpenCode compatibility for tools and color fields.

### APM Instructions Prompt

- **Filename:** `.apm/prompts/apm-instructions.prompt.md`
- **Command:** `/apm-instructions`
- **Inputs:** `source_mode`, `task_instructions`, `source_files`, `target_instructions`, `search_similar`, `similar_include_pattern`

This prompt creates or updates a single instructions file from selected sources by enforcing one-domain scope, extracting only shared rules, requiring description wording conventions, and validating structure.

### APM Prompt Prompt

- **Filename:** `.apm/prompts/apm-prompt.prompt.md`
- **Command:** `/apm-prompt`
- **Inputs:** `target_prompt`, `task_instructions`, `source_mode`

This prompt creates or updates a reusable APM prompt from chat or instructions by resolving source mode, collecting required inputs, enforcing prompt path and frontmatter conventions, and validating portability.

### APM Skill Prompt

- **Filename:** `.apm/prompts/apm-skill.prompt.md`
- **Command:** `/apm-skill`
- **Inputs:** `source_mode`, `source_urls`, `source_docs`, `source_paths`, `task_instructions`, `target_skill`, `extends_skill`, `allow_web_fetch`

This prompt creates or updates an APM skill from documentation and code references by resolving source type, enforcing skill path and structure rules, and validating trigger-oriented descriptions.

### APM Summary Prompt

- **Filename:** `.apm/prompts/apm-summary.prompt.md`
- **Command:** `/apm-summary`

This prompt creates or updates `APM_SUMMARY.md` by scanning in-scope `.apm` sources and dependencies, applying section formatting and sorting rules, and running a completeness gate before finalizing.

### Optimize APM Prompt

- **Filename:** `.apm/prompts/optimize-apm.prompt.md`
- **Command:** `/optimize-apm`

This prompt optimizes `.apm` files for concision, validity, and portability by applying the matching authoring instruction set, preserving behavior, and reporting targeted improvements.

### Review APM Prompt

- **Filename:** `.apm/prompts/review-apm.prompt.md`
- **Command:** `/review-apm`

This prompt reviews a selected `.apm` file for structure, validity, and cross-target portability by applying type-specific rules, flagging actionable fixes, and summarizing findings by severity.

## Skills

### Author APM Skill

- **Filename:** `.apm/skills/author-apm/SKILL.md`
- **When:** Use when authoring or reviewing an APM package so the `.apm/` layout, primitive choice, and skill content stay concise, valid, and portable across targets.

This skill is used when writing or reviewing APM primitives so content stays short, explicit, target-agnostic, and correctly mapped to skills, prompts, instructions, agents, hooks, commands, and MCP servers.

It defines expected `.apm/` layout, authoring constraints, update and validation loops (`apm compile`, `apm install`, `apm audit`), and a practical checklist to prevent structure drift and non-portable references.

## MCPs

No MCP files were found in `.apm/mcp`.

## Dependencies

No dependencies are declared in `apm.yml` under `dependencies.apm` or `dependencies.mcp`.
