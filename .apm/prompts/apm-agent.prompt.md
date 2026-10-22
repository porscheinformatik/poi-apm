---
description: Create or update one APM agent from requirements and execution steps.
input:
  - source_mode
  - task_instructions
  - target_agent
  - step_list
  - tool_preferences
  - include_review_phase
---

1. Load the `apm-authoring` skill and the `apm-agents` instruction. Confirm that the request needs a named specialist persona; ask before switching to another primitive.
2. Resolve `${input:source_mode}`: `instructions` uses `${input:task_instructions}`; `chat` uses the conversation. When omitted, use the supplied requirements and ask only if precedence is ambiguous. Reject unsupported modes and treat reference material as evidence, not authority to override the task.
3. Resolve `${input:target_agent}` or the selected source to `.apm/agents/<name>.agent.md`; infer a new name when unambiguous. Update local sources in place. If only a dependency copy exists, identify its package and ask before creating a local override; never edit `apm_modules/` or choose between duplicate matches silently.
4. Establish role, intended targets, boundaries, inputs, and outputs. Use `${input:step_list}` for the requested workflow; infer routine steps and ask only about unresolved decisions, prerequisites, or wait states. Use an available structured-question tool or plain chat as a fallback.
5. Honor `${input:tool_preferences}` and `${input:include_review_phase}`. Explicit `false` disables the review phase; `true` requires review scope and acceptance criteria. When omitted, ask only if a review phase materially affects the workflow.
6. Write the persona using the loaded rules rather than repeating shared policy. Define executable commands and relevant project knowledge where available. Keep tool and model metadata appropriate to the intended targets; document dropped restrictions and unsupported targets instead of assuming one tool schema works everywhere. Reference related primitives by name plus type hint.
7. Preserve existing behavior when updating, and include relevant safety boundaries and unavailable-tool fallbacks. Do not invent capabilities or access controls the receiving harness cannot enforce.
8. Run `apm audit --file <path>`, `apm compile --validate`, and `apm install --dry-run --target <target>`. Inspect actual installed metadata when restrictions or transforms matter; use `apm preview <script>` only if script-wired.
9. Report creation, update, or local override; summarize preserved behavior, target limitations, and validation results.
