---
description: Review .apm files for concision, validity, and cross-target portability.
---

1. If no target file is selected or provided, ask for it using the askQuestions MCP.
2. Load the author-apm skill before reviewing any .apm file.
3. Load the matching instruction by name and type hint for the target file type:
   - apm-instructions.instructions.md for .apm/instructions/\*.instructions.md
   - apm-agents.instructions.md for .apm/agents/\*.agent.md
   - apm-prompts.instructions.md for .apm/prompts/\*.prompt.md
   - apm-skills.instructions.md for .apm/skills/\*\*/SKILL.md
4. Review only. Do not edit files, apply patches, or generate replacement files.
5. Check layout and filename conventions first. If structure is wrong, explain the mismatch, why it affects portability, and the exact fix.
6. Evaluate concision, validity, and portability:
   - Flag unsupported frontmatter keys and explain what survives across targets.
   - Flag mixed responsibilities and explain why single-intent prompts are easier to maintain.
   - Flag invalid prompt structure and explain how deterministic steps improve reliability.
   - Flag non-portable source-tree links and explain how package consumers can break on local paths.
7. Keep feedback specific and actionable:
   - Provide short, imperative replacement wording that preserves intent.
   - Add a brief explanation after each recommendation so the user learns the pattern, not just the fix.
8. For minor-only issues, ask whether to return suggested wording changes now or skip recommendations.
9. Summarize findings by severity first, then list optional concision improvements.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.
