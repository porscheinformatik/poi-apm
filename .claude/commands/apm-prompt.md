---
description: Create or update a prompt based on an existing chat.
---

1. If no target prompt file is selected or provided, ask where the target prompt file is.
2. Require the target to live in `.apm/prompts/` and end with `.prompt.md`; if not, explain the mismatch and fix the path or name.
3. Load the `author-apm` skill and the prompt instruction file for prompt conventions before editing.
4. If the target prompt exists, improve it in place; otherwise create it in `.apm/prompts/` with the `.prompt.md` suffix.
5. Keep one intent per prompt and write short, imperative, deterministic steps.
6. Ensure the frontmatter `description` is short, user-facing, and action-oriented (it should describe a doing).
7. Keep only preserved frontmatter keys and fix invalid prompt structure before finishing.
8. Avoid source-tree-relative links in the body; use portable wording instead.
9. Report what changed and why, then suggest any optional concision improvements.