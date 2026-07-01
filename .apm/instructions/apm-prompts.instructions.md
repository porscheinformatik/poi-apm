---
name: apm-prompts
description: Describes how to write prompts for the Agent Package Manager (APM).
applyTo: ".apm/prompts/*.prompts.md"
---

Use this file when authoring APM prompt files.

## What a prompt is

- A prompt is an on-demand, single-purpose workflow.
- Use prompts for explicit commands such as review PR or draft release notes.
- Use skills for auto-discovered guidance during conversation.

## Prompt file rules

- Put prompt files in .apm/prompts/.
- Use the .prompt.md suffix.
- Keep one intent per file.
- Prefer short, direct, imperative instructions.

## Supported frontmatter

Only these keys are preserved across targets:

- description: one-line summary used in pickers.
- input: list of parameters.
- allowed-tools: optional tool allow-list.
- model: optional model preference.
- argument-hint: optional picker hint.

Notes:

- Extra frontmatter keys may be dropped on some targets.
- Input placeholders in body should use ${input:name}.
- Input names should match [A-Za-z][\w-]{0,63}.

## Body conventions

- Write in second person.
- Start with the action.
- Keep flow linear and deterministic.
- Split branching workflows into separate prompts.

## Target behavior summary

- Copilot, Claude, Cursor, OpenCode, Gemini, and Windsurf receive prompt/command outputs.
- Codex has no prompts primitive.
- Command names come from the prompt filename stem.

## Common mistakes

- Using prompts for always-on policy (use instructions instead).
- Packing multiple workflows into one prompt.
- Depending on non-preserved frontmatter keys.
- Defining invalid input names.
- Reusing the same prompt filename in multiple locations.

## Validation checklist

- Run apm compile --validate.
- Run apm install --dry-run --target <target>.
- If script-wired, run apm preview <script>.
