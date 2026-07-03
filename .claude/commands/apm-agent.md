---
description: Create or update an APM agent from requirements.
---

1. If no target agent file is selected or provided, ask where the target agent file is.
2. Require the target to live in `.apm/agents/` and end with `.agent.md`; if not, explain the mismatch and fix the path or name.
3. Load the `author-apm` skill and the agent instruction file for agent conventions before editing.
4. If the target agent exists, improve it in place; otherwise create it in `.apm/agents/` with the `.agent.md` suffix.
5. Ensure frontmatter uses recommended keys `name` and `description`, and only add optional keys (`model`, `tools`, `color`, `handoffs`) when needed.
6. Ensure the frontmatter `description` is short, user-facing, and action-oriented (it should describe a doing).
7. Keep the body concise and role-focused: start with role and scope, state what the persona does and does not do, and list expected inputs and produced outputs.
8. For OpenCode compatibility, ensure `tools` is a boolean mapping (not a list) and `color` is a hex value or supported theme token when present.
9. Keep only valid agent structure and fix invalid frontmatter or layout before finishing.
10. Report what changed and why, then suggest any optional concision improvements.