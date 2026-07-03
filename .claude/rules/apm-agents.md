---
paths:
  - ".apm/agents/*.agent.md"
---

Use this file when authoring APM agent files.

## What an agent is

- An agent is a named persona invoked explicitly.
- It controls who the model becomes for a task.

## When to use agents

- Use agents for invoked workflows, specialist behavior, model and tool constraints, or multi-step role behavior.
- Keep agent files focused on role behavior, not file-pattern policy.

## Agent authoring rules

- Store agent files in .apm/agents/.
- Name files with .agent.md suffix.
- Recommended frontmatter keys: name, description.
- Optional keys: model, tools, color, handoffs.

Description guidance:

- A short, user-facing description of the agent's role.
- Lead with user intent and trigger conditions.
- Keep the description concise and specific.

Body guidance:

- Start with role and scope.
- State what the persona does and does not do.
- List expected inputs and produced outputs.
- Keep the file concise.

## Target behavior summary

- Copilot, Claude, Cursor, and OpenCode: deployed as agent files.
- Codex: converted to TOML agent format.
- Windsurf, Kiro, and Gemini: no agent primitive deployment; use skills when persona behavior must reach these targets.

OpenCode compatibility notes:

- tools must be a boolean mapping, not a list.
- color must be a hex value or supported theme token.

## Common mistakes

- Using an agent where an instruction is enough.
- Writing oversized agent bodies that duplicate global rules.
- Using invalid tools or color shapes for OpenCode-targeted agents.

## Validation checklist

- Run apm compile --validate.
- Run apm install --dry-run --target <target>.
- If wired via scripts, run apm preview <script>.
