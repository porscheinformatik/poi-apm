---
name: apm-skills
description: Rules for writing Skills for the Agent Package Manager (APM).
applyTo: ".apm/skills/**/SKILL.md"
---

Use this file when authoring APM skill files.

## What a skill is

- A skill is runtime-invoked guidance selected from its description.
- Use skills for reusable task playbooks and domain workflows.
- Keep SKILL.md focused; move deep context to supporting files.

## Skill layout rules

- Store each skill in its own directory under .apm/skills/<name>/.
- Require SKILL.md.
- Optional folders: scripts/, references/, assets/, examples/.
- The directory name is the skill identity.

## Frontmatter rules

- Recommended keys: name, description.
- name should match the parent directory name.
- name format: lowercase letters, numbers, and hyphens.
- Avoid leading, trailing, or repeated hyphens.

Description guidance:

- Start with an imperative trigger such as Use when or Apply when.
- Lead with user intent and trigger conditions.
- Describe situations, not slash commands.
- Keep descriptions concise and specific.

## Body guidance

- Keep SKILL.md short and operational.
- Prefer direct steps and clear boundaries.
- Put long references in references/\*.md.
- Use explicit LOAD references/<file> lines for optional deep context.

## Target behavior summary

- Claude deploys to .claude/skills/<name>/SKILL.md.
- Kiro deploys to .kiro/skills/<name>/SKILL.md.
- Copilot, Cursor, Codex, Gemini, OpenCode, and Windsurf deploy to .agents/skills/<name>/SKILL.md.
- Skill directories are copied with bundled resources.

## Common mistakes

- Vague descriptions that collide with other skills.
- Frontmatter name not matching directory name.
- Oversized SKILL.md files that reduce runtime context quality.
- Forgetting to separate optional deep-dive content into references/.
- Using invalid or unsupported target names in apm.yml.

## Validation checklist

- Run apm compile --validate.
- Run apm install --dry-run --target <target>.
- Run apm audit --file .apm/skills/<name>/SKILL.md.
