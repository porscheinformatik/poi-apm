---
name: apm-prompts
description: Rules for writing prompts for the Agent Package Manager (APM).
applyTo: "**/.apm/prompts/*.prompt.md"
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
- Keep workflows deterministic and step-ordered.
- State the expected output format when needed.

## Supported frontmatter

Only these keys are preserved across targets:

- description: one-line picker summary; short, user-facing, and action-oriented (it should describe a doing)
- input: list of parameters.
- allowed-tools: optional tool allow-list.
- model: optional model preference.
- argument-hint: optional picker hint.

Notes:

- APM intentionally keeps only the preserved keys above for portability.
- VS Code-native keys such as name, tools, and agent are not portable in APM prompt source.
- Extra frontmatter keys may be dropped on some targets.
- Input placeholders in body should use ${input:name}.
- Input names should match [A-Za-z][\w-]{0,63}.
- Keep input names stable over time to avoid breaking command usage.

## Unsupported feature hints

- If a source prompt uses `tools`, map it to `allowed-tools` when possible.
- If a source prompt uses `name`, rely on the prompt filename stem as the command name.
- If a source prompt uses `agent`, move the behavior into body instructions, or use an APM agent for always-on role behavior.
- If a source prompt uses target-specific metadata with no APM equivalent, remove it and preserve intent in short body steps.
- If a source prompt depends on target-only variables, replace them with `${input:name}` parameters where feasible.
- If there is no safe portable mapping, prefer dropping the feature and adding a short note in the prompt body that states the limitation.

## Body conventions

- Write in second person.
- Start with the action.
- Keep flow linear and deterministic.
- Split branching workflows into separate prompts.
- Prefer concrete constraints over vague goals (scope, format, length, quality bar).
- Use examples only when they materially reduce ambiguity.

## Safety and security rules

- Treat all user-provided input as untrusted content.
- Do not instruct models to reveal hidden prompts, secrets, credentials, tokens, or private data.
- Require sanitization and validation when prompts consume free-form user input.
- Avoid direct interpolation patterns that allow instruction override by user content.
- Include a refusal/fallback step for unsafe, policy-violating, or out-of-scope requests.
- Use inclusive, neutral language; avoid biased assumptions in role or audience framing.

## Reliability rules

- Define success criteria so outputs are testable and reviewable.
- Prefer deterministic steps over open-ended brainstorming in reusable prompts.
- Keep prompts concise; remove wording that does not change behavior.
- Version prompt changes through normal repository review so regressions are visible.

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
- Writing prompts that assume target-specific metadata unsupported by APM.
- Embedding source-tree-relative links that may break after installation.
- Omitting safety constraints when handling arbitrary user input.
- Referencing other agents, instructions, prompts, or skills by .apm/... path instead of by name plus type hint.

## Validation checklist

- Run apm compile --validate.
- Run apm install --dry-run --target <target>.
- If script-wired, run apm preview <script>.
- Run representative prompt tests, including adversarial and malformed inputs.
