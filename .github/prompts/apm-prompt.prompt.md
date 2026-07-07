---
description: Create or update a reusable APM prompt from chat or instructions.
input:
  - target_prompt
  - task_instructions
  - source_mode
argument-hint: Optional target prompt and/or instructions; defaults to reusing the current chat.
---

1. Load prompt authoring guidance before editing:
   - the `author-apm` skill
   - the `apm-prompts` instruction rules
2. Determine intent and source:
   - If `${input:source_mode}` is `instructions`, use `${input:task_instructions}` as the source.
   - If `${input:source_mode}` is `chat` or omitted, default to making the current chat reusable as a prompt.
   - If both chat context and `${input:task_instructions}` are provided, ask which source should be primary.
3. Identify required inputs for the prompt before writing:
   - infer required parameters for future prompt users
   - define stable, valid input names
   - ask follow-up questions when needed
4. Resolve the target prompt path:
   - prefer `${input:target_prompt}` when provided
   - otherwise infer from the user request and confirm when ambiguous
   - enforce `.apm/prompts/<name>.prompt.md`
5. When updating an existing prompt:
   - if the file exists in `.apm/prompts/`, edit it in place
   - if it does not exist locally, search `apm_modules/**` for the same prompt filename
   - if found in `apm_modules`, copy it into `.apm/prompts/` first, then edit the local copy
   - if not found, ask whether to create a new local prompt with that name
6. When creating a prompt:
   - create a new file in `.apm/prompts/` with the `.prompt.md` suffix
   - support creation from either chat context or explicit instructions
7. Write or update the prompt using APM conventions:
   - one intent per prompt
   - short, imperative, deterministic steps
   - preserved frontmatter keys only
   - portable wording with no source-tree-relative links
   - include safety/fallback behavior for unsafe or out-of-scope requests when relevant
8. If the prompt requires user decisions at runtime, instruct use of the `askQuestions` MCP to collect required values.
9. Validate structure and quality:
   - frontmatter is valid and action-oriented
   - input placeholders use `${input:name}` consistently
   - make output/reporting expectations explicit when needed
10. Report what changed, why, and whether the prompt was created, updated in place, or copied from `apm_modules` then updated.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.
