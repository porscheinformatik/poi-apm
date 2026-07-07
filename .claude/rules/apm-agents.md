---
paths:
  - ".apm/agents/*.agent.md"
---

## What an agent is

- An agent is a named specialist persona invoked explicitly by name (e.g. `@security-review`) — not a general helper, but a focused role.
- Instructions scope file-pattern rules; agents scope who the model becomes when summoned.

## When to use agents

- Use agents for invoked workflows, specialist behavior, model and tool constraints, or multi-step role behavior.
- Use instructions instead when the rule applies to a file pattern and fires implicitly.
- Keep agent files focused on role behavior, not file-pattern policy. Do not co-mingle style rules and persona.

## Agent authoring rules

- Store agent files in `.apm/agents/`.
- Name files with `.agent.md` suffix. Do not name agents `default` or `start` — those collide with script resolution in `apm run`.
- Required frontmatter: `description`.
- Recommended frontmatter: `name` (defaults to filename stem if omitted).
- Optional keys: `model`, `tools`, `color`, `handoffs`.

### Description

- One sentence. Used by harnesses to decide when to surface the agent.
- Lead with user intent and trigger conditions, not the agent's internal mechanics.
- Be specific: "Reviews diffs for OWASP top-10 issues" beats "Helps with security."

### Body conventions

Cover these areas in order, opening with role and scope (two sentences — this becomes the system prompt):

1. **Role and scope** — Who the agent is and what it specializes in. Be concrete: name the framework, language, or domain.
2. **Commands** — Exact executable commands the agent can run (`npm test`, `pytest -v`, including flags). Put these early.
3. **Project knowledge** — Relevant file structure, tech stack with versions, key paths it reads from or writes to.
4. **Standards and examples** — One real code snippet showing expected style beats three paragraphs describing it.
5. **Boundaries** — Use a three-tier structure:
   - **Always do:** Actions the agent must take without asking.
   - **Ask first:** Changes that need user confirmation (schema changes, adding dependencies, CI config).
   - **Never do:** Hard constraints (secrets, vendor directories, source files in a doc-only agent).
6. **Inputs and outputs** — What the agent expects ("the open PR diff") and what it returns ("a markdown review with file:line citations").

Keep the body under 300 lines. Agents inherit the workspace's compiled context — do not restate global instructions or rules already covered by an instruction file.

## Target behavior summary

| Target                            | Deployment                                               |
| --------------------------------- | -------------------------------------------------------- |
| Copilot, Claude, Cursor, OpenCode | Deployed as agent files verbatim                         |
| Codex                             | Converted to TOML; body becomes `developer_instructions` |
| Windsurf                          | **Not deployed** — no agents primitive                   |
| Kiro                              | **Not deployed** — no agents primitive                   |
| Gemini                            | **Not deployed** — no agents primitive                   |

If a persona must reach Windsurf, Kiro, or Gemini, author it as a skill under `.apm/skills/<name>/SKILL.md` instead. Cascade (Windsurf) auto-invokes skills by their `description` field.

### OpenCode compatibility

- `tools` must be a boolean mapping, not a list: `tools: {Read: true, Grep: true}` not `tools: [Read, Grep]`.
- `color` must be a `#rrggbb` hex literal or one of: `primary`, `secondary`, `accent`, `success`, `warning`, `error`, `info`.
- `apm install -t opencode` warns at install time when either shape is wrong; the file deploys but OpenCode rejects it at load.

## Converting agents from other systems

Map features to the closest APM primitive; document what was dropped.

### From GitHub Copilot (`agents.md`)

- A single `agents.md` file may define multiple personas via headings. Split each persona into its own `.agent.md` file.
- `model`, `tools`, and `description` frontmatter map directly to APM frontmatter fields.
- `handoffs` (agent-to-agent routing) is supported as an optional frontmatter list.

### From Windsurf skills or Kiro personas used as agents

- Windsurf and Kiro have no agent primitive; invocable personas in those systems are skills.
- If the persona must also reach Copilot, Claude, Cursor, or OpenCode, author it as both a `.agent.md` and a skill.

### Unsupported features — how to handle them

| Feature in source system                                  | APM handling                                                                                                             |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Inline tool definitions or custom tool schemas            | Strip. APM `tools` is a whitelist of harness-native tool names, not definitions. Move custom logic to a skill or prompt. |
| Memory / conversation persistence config                  | Strip. APM has no memory primitive. Document the expectation in the agent body as a behavioral instruction.              |
| RAG or knowledge-base attachment                          | Strip. Reference the knowledge source by path in the body as a convention, not a wired config.                           |
| Trigger conditions or auto-invocation rules               | Strip for agent files (agents are always invoked explicitly). If auto-invocation is needed, re-author as a skill.        |
| MCP server references inside agent config                 | Move to a separate `.apm/mcp/<name>.mcp.json` entry; reference it by name in the agent body as context.                  |
| Multiple `model` fallbacks or routing logic               | Pick one `model` value. Document the fallback preference in the body as a note.                                          |
| Agent-level system prompt injection from an external file | Inline the content into the body. APM agent bodies are self-contained.                                                   |

## Common mistakes

- Using an agent where an instruction is enough. If a rule applies to a file pattern, it is an instruction.
- Writing a vague persona: "You are a helpful assistant" does not work. Name the specialization.
- Oversized bodies that duplicate global rules already in an instruction file.
- Using `tools` as a list or an unsupported `color` value for OpenCode-targeted agents.
- Targeting Windsurf, Kiro, or Gemini with an agent file — those targets do not receive agent files.
- Naming an agent `default` or `start`.
- Referencing other agents, instructions, prompts, or skills by `.apm/...` path instead of by name plus type hint.
- A body that co-mingles persona, style rules, and review checklist. Split it.

## Validation checklist

- Run `apm compile --validate`.
- Run `apm install --dry-run --target <target>`.
- If wired via scripts, run `apm preview <script>`.
