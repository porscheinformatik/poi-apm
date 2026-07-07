---
argument-hint: <source_mode> <task_instructions> <target_agent> <step_list> <tool_preferences>
  <include_review_phase>
arguments:
- source_mode
- task_instructions
- target_agent
- step_list
- tool_preferences
- include_review_phase
description: Create or update one APM agent from requirements and execution steps.
---

1. Confirm intent first:
   - If the user wants to create or update an agent, continue.
   - If a prompt or instructions primitive is a better fit, ask the user to confirm switching and then follow the apm-prompt or apm-instructions prompt workflow.
2. Resolve source mode:
   - If $source_mode is instructions, use $task_instructions as the primary source.
   - If $source_mode is chat or omitted, use chat intent plus provided requirements.
3. Collect missing requirements with askQuestions when needed:
   - Ask for explicit step lists if steps are missing or ambiguous.
   - Ask how each step should execute, including preconditions, postconditions, and whether the step waits for user input.
   - Suggest candidate step breakdowns when the user has not provided enough detail, then ask the user to confirm or revise.
4. Resolve target agent path:
   - Prefer $target_agent when provided.
   - If no target is provided, ask where the target agent file is.
   - Hint that agent files are typically at .apm/agents/<agent-name>.agent.md.
   - If the agent is not local, look for it in apm_modules/\*\* and copy it to .apm/agents/<agent-name>.agent.md before editing.
   - Enforce .apm/agents/<name>.agent.md.
5. If the target agent exists in .apm/agents/, update it in place; otherwise create a new file in .apm/agents/ with the .agent.md suffix.
6. Apply APM agent conventions when writing:
   - Keep frontmatter valid with required description and recommended name.
   - Add optional keys (model, tools, color, handoffs) only when needed.
   - Keep description short, user-facing, and action-oriented.
   - Keep tools as a boolean mapping when present.
7. Structure the agent as a useful multi-step workflow:
   - Treat agents as multi-step execution flows by default.
   - Capture ordered steps, decision points, and stop/wait states.
   - Include expected inputs, outputs, and boundaries.
8. Allow references to other primitives when useful:
   - Reference related agents, skills, and prompts by name plus type hint.
   - Avoid duplicate instructions when behavior is already defined elsewhere.
9. Review phase planning:
   - Ask whether the user wants a review phase after specific steps when feasible.
   - If enabled, specify what is reviewed and the acceptance criteria before continuing.
10. Tool planning:
    - Check whether the workflow needs specific tools and ask the user to confirm tool preferences in $tool_preferences when unclear.
11. Encourage use of askQuestions MCP in agent behavior when runtime user decisions are required.
12. Include refusal or fallback behavior for unsafe, policy-violating, or out-of-scope requests when relevant.
13. Validate structure and portability, then report what changed, why, and whether the agent was created or updated.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.