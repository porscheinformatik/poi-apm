---
name: apm-migrate-prompt-to-skill
disable-model-invocation: true
description: Migrate APM prompt files (.apm/prompts/*.prompt.md) to skills, since prompt files are no longer supported.
input:
  - target_prompts
  - skill_invocation
argument-hint: Optional prompt name(s) or paths; defaults to all files in .apm/prompts. Optionally set skill_invocation to explicit or auto.
---

1. Load the `apm-authoring` skill and the `apm-skills` instruction. Resolve `${input:target_prompts}` to files under `.apm/prompts/*.prompt.md`; when omitted, use all of them. Do not edit `apm_modules/` or generated output (`.claude/commands/`, `.github/prompts/`); report prompts found only in dependencies.
2. Resolve invocation per prompt using `${input:skill_invocation}`: `explicit` (default) adds `disable-model-invocation: true`; `auto` omits it. Reject other values. Prompts are explicit by nature, so ask only when the user hints that a prompt should be discovered automatically.
3. For each prompt `<name>.prompt.md`, move it with `git mv` (or `mv`) to `.apm/skills/<name>/SKILL.md`. If that skill already exists, stop and ask before merging; never overwrite silently.
4. Edit the frontmatter in place without rewriting the body: add `name: <name>` (matching the directory) and, for explicit skills, `disable-model-invocation: true`. Keep `description`, `input`, `argument-hint`, and all `${input:...}` placeholders unchanged. Rewrite a description only if it is empty.
5. Update `apm.yml` `includes:` entries from `.apm/prompts/<name>.prompt.md` to `.apm/skills/<name>/SKILL.md`. Replace references to the prompt in other primitives with the skill name plus a `skill` type hint.
6. Remove `.apm/prompts/` only when it holds no remaining prompt files; keep or ask about non-prompt files such as `AGENTS.md`. Do not delete the `apm-prompts` instruction unless asked.
7. Run `apm audit --file <path>` on each migrated file, `apm compile --validate`, and `apm install --dry-run`. Fix failures and re-run. Do not claim these checks prove runtime behavior.
8. Report migrated skills, their invocation mode, manifest and reference updates, skipped items, and validation results. Mention that generated output refreshes only after `apm install` or `apm compile`.
