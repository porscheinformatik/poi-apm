---
description: Review .apm files for concision, validity, and cross-target portability.
---

1. If no target file is selected or provided, ask the user to specify one.
2. Load .apm/skills/author-apm/SKILL.md before reviewing any .apm file.
3. Load the matching instruction file for the target file type:
   - .apm/instructions/apm-instructions.instructions.md for .apm/instructions/\*.instructions.md
   - .apm/instructions/apm-agents.instructions.md for .apm/agents/\*.agent.md
   - .apm/instructions/apm-prompts.instructions.md for .apm/prompts/\*.prompt.md
   - .apm/instructions/apm-skills.instructions.md for .apm/skills/\*\*/SKILL.md
4. Check layout and filename conventions first. If structure is wrong, explain the mismatch and suggest the exact fix.
5. Flag and suggest fixes for common issues: unsupported frontmatter keys, mixed responsibilities, invalid prompt structure, and non-portable source-tree links.
6. Keep feedback specific and actionable: show concise replacement wording in short, imperative form without changing intent.
7. Summarize findings by severity, then list optional concision improvements.