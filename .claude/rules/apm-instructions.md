---
paths:
  - ".apm/instructions/*.instructions.md"
---

Use this file when authoring APM instruction files.

## What an instruction is

- An instruction is always-on policy scoped by file glob.
- It controls how the model behaves for matching files.

## When to use instructions

- Use instructions for file-pattern rules, coding standards, and checklists.
- Keep instruction files focused on long-lived policy, not persona behavior.

## Instruction authoring rules

- Store instruction files in .apm/instructions/.
- Name files with .instructions.md suffix.
- Keep one topic per file.
- Keep content short and rule-like.
- Prefer bullet lists over long prose.

Description guidance:

- Usually starts with "Rules for" or "Guidelines for" a specific set of files.
- Lead with user intent and trigger conditions.
- Keep the description concise and specific.

Required frontmatter for instructions:

- description: one-line summary.
- applyTo: glob or comma-separated globs.

Notes for applyTo:

- Missing applyTo makes the rule unconditional and it may be folded into compiled context files.
- For multiple patterns, prefer one comma-separated string.
- YAML list form is accepted, but if multiple list entries are present, only the first is used by APM.
- Commas inside brace expansion are part of one glob, for example \*_/_.{css,scss}.

## Target behavior summary

- Copilot: deployed as per-file instruction files.
- Claude/Cursor/Windsurf/Kiro: deployed as rule files with transformed glob fields.
- Codex/Gemini/OpenCode: folded into compiled context files.

## Common mistakes

- Missing applyTo on instructions.
- Using an instruction for persona-only behavior (use an agent instead).
- Applying multiple unrelated topics in one instruction file.

## Validation checklist

- Run apm compile --validate.
- Run apm install --dry-run --target <target>.
- If wired via scripts, run apm preview <script>.
