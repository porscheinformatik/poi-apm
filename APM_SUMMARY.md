# APM Summary

## Agents

No agent files were found in .apm/agents.

## Instructions

### APM Agents Instructions

- **Filename:** apm-agents.instructions.md
- **Apply To:** .apm/agents/\*.agent.md

This instruction is used to define how APM agent files are authored, scoped, and validated so agent personas stay concise, role-focused, and portable across targets.

### APM Instructions Instructions

- **Filename:** apm-instructions.instructions.md
- **Apply To:** .apm/instructions/\*.instructions.md

This instruction is used to define always-on policy file conventions, including required frontmatter, applyTo usage, topic scoping, and deterministic validation for instruction rules.

### APM Prompts Instructions

- **Filename:** apm-prompts.instructions.md
- **Apply To:** .apm/prompts/\*.prompts.md

This instruction is used to standardize APM prompt authoring by enforcing one intent per file, preserved frontmatter keys, deterministic body flow, and command-oriented portability across supported targets.

### APM Skills Instructions

- **Filename:** apm-skills.instructions.md
- **Apply To:** .apm/skills/\*\*/SKILL.md

This instruction is used to define APM skill structure, naming, frontmatter, and concise operational content so runtime skill matching remains reliable and cross-target deployment stays valid.

## Prompts

### Create APM Instructions Prompt

- **Filename:** create-apm-instructions.prompt.md
- **Command:** /create-apm-instructions

This prompt creates one new `.instructions.md` file from a selected set of source files by enforcing one domain and one wildcard pattern, extracting only shared rules, and validating the output against instruction conventions before summarizing inclusions and exclusions.

### Create APM Prompt Prompt

- **Filename:** create-apm-prompt.prompt.md
- **Command:** /create-apm-prompt

This prompt creates or updates a target prompt in `.apm/prompts/` with a valid `.prompt.md` name, loads required APM guidance first, keeps one deterministic intent, and fixes unsupported structure before reporting changes.

### Create APM Skill Prompt

- **Filename:** create-apm-skill.prompt.md
- **Command:** /create-apm-skill

This prompt creates a new skill from documentation URLs or local code samples, avoids duplicating instructions when extending existing skills, and produces concise skill content aligned to APM skill conventions.

### Create APM Summary Prompt

- **Filename:** create-apm-summary.prompt.md
- **Command:** /create-apm-summary

This prompt creates or refreshes `APM_SUMMARY.md` from `.apm` sources, enforces fixed section structure and strict item formatting, and summarizes what changed with optional concision recommendations.

### Improve APM Prompt

- **Filename:** improve-apm.prompt.md
- **Command:** /improve-apm

This prompt improves selected `.apm` files by loading the matching rule set, correcting layout and filename mismatches first, tightening verbose wording into short imperative guidance, and reporting concrete fixes plus optional refinements.

### Review APM Prompt

- **Filename:** review-apm.prompt.md
- **Command:** /review-apm

This prompt reviews a selected `.apm` file for structure, validity, and portability by applying type-specific rules, flagging precise issues with actionable replacements, and summarizing findings by severity.

## Skills

### Author APM Skill

- **Filename:** .apm/skills/author-apm/SKILL.md
- **When:** Use when authoring or reviewing an APM package so the `.apm/` layout, primitive choice, and skill content stay concise, valid, and portable across targets.

This skill is used when writing or reviewing APM primitives so content stays short, explicit, target-agnostic, and correctly mapped to skills, prompts, instructions, agents, hooks, commands, and MCP servers.

It defines expected `.apm/` layout, authoring constraints, update and validation loops (`apm compile`, `apm install`, `apm audit`), and a practical checklist to prevent structure drift and non-portable references.
