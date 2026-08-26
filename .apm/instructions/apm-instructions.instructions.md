---
name: apm-instructions
description: Rules for writing Instructions for the Agent Package Manager (APM).
applyTo: "**/.apm/instructions/*.instructions.md"
---

## What an instruction is

- An instruction is always-on policy scoped by a file glob.
- It shapes model behavior silently for matching files — no user invocation needed.
- Use instructions for long-lived standards; use agents for on-demand specialist personas.

## When to use instructions

- File-pattern rules: coding standards, naming conventions, formatting.
- Review checklists that should apply whenever matching files are touched.
- Framework-specific guidance scoped to a directory or language.
- Do NOT use for persona-only behavior (use an agent instead).

## Required frontmatter

- `description` (required): one-line summary. Usually starts with "Rules for" or "Guidelines for". Lead with user intent and trigger conditions.
- `applyTo`: glob or comma-separated globs. Without it the rule is treated as unconditional and folded into compiled context files instead of a per-file rule.

Optional frontmatter:

- `name`: display name shown in the UI. Defaults to the filename stem if omitted.

## applyTo rules

- Prefer a comma-separated string over a YAML list for identical output across all targets: `"**/*.ts, **/*.tsx"`.
- YAML list form is accepted; only the first entry is used on targets that don't support multiple globs. Prefer comma-separated.
- Commas inside brace expansion are part of the glob, not list separators: `**/*.{css,scss}`.
- Use `**` only for rules that genuinely apply to every file. Scope language-specific rules to the language: `**/*.py`, not `**`.

## Body conventions

- Lead with bullets, not prose. Instructions are read by an agent mid-task.
- One topic per file. Split `python-style` and `python-tests`; do not co-mingle.
- State the rule directly. Skip greetings and meta ("In this file we will…").
- Be specific and actionable: "Use `pathlib.Path`, never `os.path`" not "use good path handling".
- Include the reasoning behind non-obvious rules. Agents make better decisions in edge cases when they know the why.
- Cite repo paths in backticks. Do not assume any other context is loaded.
- Show correct patterns with code examples for complex rules.
- Focus on rules that linters and formatters do not already enforce automatically.

## Target behavior summary

- Copilot: deployed as `.github/instructions/<name>.instructions.md`; `applyTo` preserved verbatim.
- Claude/Cursor/Windsurf/Kiro/Antigravity: deployed as rule files with `applyTo` transformed to the target's native glob field.
- Codex/Gemini/OpenCode: folded into compiled context files (`AGENTS.md`, `GEMINI.md`); no per-file rule deployed.

## Unsupported features (conversion guidance)

- `@-style imports` (`@shared/rules.md`): inline the referenced content directly into the body, or extract it into a separate APM instruction file with its own `applyTo` glob.
- Settings-based instructions (`github.copilot.chat.*` settings for code review, commit messages, PR descriptions): convert to a regular instruction file with an appropriate `applyTo` glob, or drop if they were target-specific UI settings with no equivalent policy.
- Organization-level instructions (GitHub org-wide): treat as workspace-level instructions and add them to `.apm/instructions/` with `applyTo: "**"` if truly project-wide, or with a scoped glob if they only apply to certain file types.
- `name` field only (no `description`): replace with a `description` that states the rule's intent — `description` is required by APM; `name` is optional and defaults to the filename stem.

## Common mistakes

- Missing `applyTo` — the rule becomes unconditional and loses per-file scoping.
- Using an instruction for persona-only behavior — use an agent instead.
- Multiple unrelated topics in one file — split into separate instruction files.
- Using a YAML list with multiple entries — prefer comma-separated string for cross-target consistency.
- Referencing other APM primitives by `.apm/...` path — use name plus type hint (e.g. "the `python-style` instruction").
- Overly broad `applyTo: "**"` on language-specific rules — scope to the relevant file types.

## Validation checklist

- Run `apm compile --validate`.
- Run `apm install --dry-run --target <target>`.
- If wired via scripts, run `apm preview <script>`.
