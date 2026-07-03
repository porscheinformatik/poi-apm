# APM Summary

## Agents

No agent files were found in .apm/agents.

## Instructions

### APM Agents Instructions

- **Filename:** .apm/instructions/apm-agents.instructions.md
- **Apply To:** .apm/agents/\*.agent.md

This instruction is used to define how APM agent files are authored, scoped, and validated so personas stay concise, role-focused, and portable across targets.

### APM Instructions Instructions

- **Filename:** .apm/instructions/apm-instructions.instructions.md
- **Apply To:** .apm/instructions/\*.instructions.md

This instruction is used to define always-on instruction policy, including required frontmatter, applyTo behavior, topic scoping, and validation expectations.

### APM Prompts Instructions

- **Filename:** .apm/instructions/apm-prompts.instructions.md
- **Apply To:** .apm/prompts/\*.prompt.md

This instruction is used to standardize APM prompt authoring with one intent per file, preserved frontmatter keys, deterministic body flow, and concise action-oriented descriptions.

### APM Skills Instructions

- **Filename:** .apm/instructions/apm-skills.instructions.md
- **Apply To:** .apm/skills/\*\*/SKILL.md

This instruction is used to define APM skill structure, naming, frontmatter, and concise operational content so runtime matching and cross-target deployment stay reliable.

## Prompts

### APM Agent Prompt

- **Filename:** .apm/prompts/apm-agent.prompt.md
- **Command:** /apm-agent

This prompt creates or updates an APM agent from requirements by enforcing agent path and suffix rules, applying agent frontmatter and body conventions, and validating OpenCode compatibility for tools and color fields.

### APM Instructions Prompt

- **Filename:** .apm/prompts/apm-instructions.prompt.md
- **Command:** /apm-instructions

This prompt creates or updates a single instructions file from selected sources by enforcing one-domain scope, extracting only shared rules, requiring description wording conventions, and validating structure.

### APM Prompt Prompt

- **Filename:** .apm/prompts/apm-prompt.prompt.md
- **Command:** /apm-prompt

This prompt creates or updates a target prompt under .apm/prompts with valid naming, preserved frontmatter keys, and short deterministic steps, including a short action-oriented description.

### APM Skill Prompt

- **Filename:** .apm/prompts/apm-skill.prompt.md
- **Command:** /apm-skill

This prompt creates or updates a skill from documentation URLs or local code samples, avoids duplicate guidance when extending skills, and enforces trigger wording in skill descriptions.

### APM Summary Prompt

- **Filename:** .apm/prompts/apm-summary.prompt.md
- **Command:** /apm-summary

This prompt creates or updates APM_SUMMARY.md by scanning in-scope .apm sources and dependencies, applying strict section formatting and sorting rules, and running a completeness gate before finalizing.

### Improve APM Prompt

- **Filename:** .apm/prompts/improve-apm.prompt.md
- **Command:** /improve-apm

This prompt improves selected .apm files by loading matching authoring rules, fixing layout and filename mismatches first, tightening wording into short imperative guidance, and reporting concrete fixes with optional refinements.

### Review APM Prompt

- **Filename:** .apm/prompts/review-apm.prompt.md
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
