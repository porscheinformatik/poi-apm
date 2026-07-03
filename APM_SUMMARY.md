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

### APM Instructions Prompt

- **Filename:** apm-instructions.prompt.md
- **Command:** /apm-instructions

This prompt creates or updates one instructions file from selected sources by confirming one domain and one wildcard scope, extracting only shared rules, and validating the result against instruction conventions.

### APM Prompt Prompt

- **Filename:** apm-prompt.prompt.md
- **Command:** /apm-prompt

This prompt creates or updates a target prompt under .apm/prompts with valid naming, loads APM authoring guidance before edits, and enforces short deterministic structure with preserved frontmatter keys.

### APM Skill Prompt

- **Filename:** apm-skill.prompt.md
- **Command:** /apm-skill

This prompt creates or updates a skill from documentation URLs or local code samples, avoids duplicate instructions when extending existing skills, and checks the output against skill instruction rules.

### APM Summary Prompt

- **Filename:** apm-summary.prompt.md
- **Command:** /apm-summary

This prompt creates or updates APM_SUMMARY.md by scanning in-scope .apm sources and dependencies, applying strict section formatting and sorting rules, and running a completeness gate before finalizing.

### Improve APM Prompt

- **Filename:** improve-apm.prompt.md
- **Command:** /improve-apm

This prompt improves selected .apm files by loading matching authoring rules, fixing layout and filename mismatches first, tightening wording into short imperative guidance, and reporting concrete fixes with optional refinements.

### Review APM Prompt

- **Filename:** review-apm.prompt.md
- **Command:** /review-apm

This prompt reviews a selected .apm file for structure, validity, and cross-target portability by applying type-specific rules, flagging actionable fixes, and summarizing findings by severity.

## Skills

### Author APM Skill

- **Filename:** .apm/skills/author-apm/SKILL.md
- **When:** Use when authoring or reviewing an APM package so the `.apm/` layout, primitive choice, and skill content stay concise, valid, and portable across targets.

This skill is used when writing or reviewing APM primitives so content stays short, explicit, target-agnostic, and correctly mapped to skills, prompts, instructions, agents, hooks, commands, and MCP servers.

It defines expected `.apm/` layout, authoring constraints, update and validation loops (`apm compile`, `apm install`, `apm audit`), and a practical checklist to prevent structure drift and non-portable references.

## Dependencies

No dependencies are declared in apm.yml.
