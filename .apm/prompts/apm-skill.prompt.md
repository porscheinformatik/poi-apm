---
description: Create or update one APM skill from documentation and/or code references.
input:
  - source_mode
  - source_urls
  - source_docs
  - source_paths
  - task_instructions
  - target_skill
  - extends_skill
  - allow_web_fetch
---

1. Confirm intent first:
   - If the request is to create or update a skill, continue.
   - If a prompt or instructions primitive is a better fit, ask the user to confirm switching and then follow the apm-prompt or apm-instructions prompt workflow.
2. Resolve source mode:
   - If ${input:source_mode} is instructions, use ${input:task_instructions} as primary source.
   - If ${input:source_mode} is chat or omitted, use chat intent plus provided sources.
3. Treat sources by type:
   - Treat URLs in ${input:source_urls} as documentation and fetch them when ${input:allow_web_fetch} is true or omitted.
   - Treat local paths in ${input:source_paths} as code references and extract behavior, constraints, and workflows from code.
   - Treat ${input:source_docs} as documentation text.
4. If required sources are missing or intent is unclear, use askQuestions to request clarification before writing.
5. Resolve target skill path:
   - Prefer ${input:target_skill} when provided.
   - If updating and no target is provided, ask where the existing SKILL.md is.
   - Hint that skill files are typically at .apm/skills/<skill-name>/SKILL.md.
   - If the skill is not local, look for it in apm_modules/\*\* and copy it to .apm/skills/<skill-name>/SKILL.md before editing.
   - Enforce one skill directory with SKILL.md under .apm/skills/<name>/.
6. If the target skill exists in .apm/skills/, update it in place; otherwise create a new skill directory and SKILL.md.
7. If ${input:extends_skill} is provided, avoid duplicated instructions, reference the existing skill by name plus type hint, and add only net-new guidance.
8. Follow the apm-skills instruction rules when writing:
   - Keep one primary purpose.
   - Keep instructions short, imperative, and deterministic.
   - Keep required frontmatter valid.
   - Ensure description starts with trigger wording such as Use when or Apply when.
9. If the skill becomes large, ask the user whether to split optional or deep content into references files.
10. If runtime decisions are required, instruct using askQuestions MCP to collect required values.
11. Include refusal or fallback behavior for unsafe, policy-violating, or out-of-scope requests when relevant.
12. Validate against apm-skills rules, then report what changed, why, and whether the skill was created or updated.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.
