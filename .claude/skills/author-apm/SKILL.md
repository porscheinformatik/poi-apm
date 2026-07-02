---
name: author-apm
description: Use when authoring or reviewing an APM package so the `.apm/` layout, primitive choice, and skill content stay concise, valid, and portable across targets.
---

Use this skill to write or review APM content for model consumption, not as long-form product documentation.

## Core model

- Treat `.apm/` as the source of truth for reusable agent context.
- Write once, then let APM project the content to supported targets.
- Prefer short, explicit instructions over explanatory prose.
- Avoid links that only work inside the source tree; installed skills may live in a different path.

## Primitive map

- Skills: capability bundles with `SKILL.md` and optional `scripts/`, `references/`, `assets/`, or `examples/`.
- Prompts: reusable prompt templates with frontmatter.
- Instructions: long-lived behavior rules and conventions.
- Agents: personas with scoped responsibilities, tools, and triggers.
- Hooks: runtime event handlers such as pre-commit or tool-use hooks.
- Commands: prompt-based shortcuts authored under `.apm/prompts/`; there is no separate `.apm/commands/` directory.
- MCP servers: server declarations that consumers can wire into their harness.

## Expected layout

```text
.apm/
  skills/
    my-skill/
      SKILL.md
      scripts/
      references/
      assets/
  prompts/
    review.prompt.md
  instructions/
    style.instructions.md
  agents/
    cli-logging-expert.agent.md
  hooks/
    pre-commit.json
```

## Skill authoring rules

- Start frontmatter descriptions with the user intent, for example `Use when ...`.
- Keep `SKILL.md` focused on decisions, constraints, and execution steps the model should follow.
- Move deep reference material into `references/` and explicitly tell the model when to load it.
- Keep examples minimal and local to the rule they support.
- Do not assume relative documentation links will resolve after installation.

## Update loop

- When editing instructions, use `apm compile --validate` for the fastest structure check.
- Use `apm compile --dry-run` to preview which files and targets would be written before changing disk.
- Use `apm compile --watch` only for fast instruction-authoring iteration.
- `apm compile` handles instructions output; it does not redeploy skills, prompts, agents, hooks, commands, or MCP servers.
- After changing non-instruction primitives, run `apm install` so the target harness directories are refreshed.
- If you are previewing a script that wraps a `.prompt.md` file, use `apm preview` rather than `apm compile`.

## Validation loop

- Run `apm compile --validate` after editing a primitive's frontmatter or structure.
- Run `apm compile --dry-run --target <target>` when you need to confirm target selection or output placement.
- Run `apm audit` before publishing or after hand-editing generated files; it checks for hidden Unicode and drift from deployed output.
- Use `apm audit --file <path>` to scan a single file.
- Use `apm audit --strip --dry-run` before removing flagged hidden characters.

## Review checklist

- The primitive is in the correct `.apm/` subdirectory.
- Frontmatter names the primitive and describes when it should be used.
- The body is short enough to fit comfortably in model context.
- File and folder names match the primitive type's expected layout.
- The content is target-agnostic and does not depend on source-repo-relative links.
- The authoring instructions distinguish `apm compile` from `apm install`.
- The file includes a minimal local validation path before packing or publishing.
