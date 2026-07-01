---
description: Improve .apm files so they stay concise, valid, and portable across targets.
---

1. If the user has not passed or selected a file, then ask the user for the file.
2. Load .apm/skills/author-apm/SKILL.md before editing any .apm file.
3. Select the matching instruction file for each target file type:
   - .apm/instructions/apm-instructions.instructions.md for .apm/instructions/\*.instructions.md
   - .apm/instructions/apm-agents.instructions.md for .apm/agents/\*.agent.md
   - .apm/instructions/apm-prompts.instructions.md for .apm/prompts/\*.prompt.md
   - .apm/instructions/apm-skills.instructions.md for .apm/skills/\*\*/SKILL.md
4. Check layout and filename conventions first. If structure is wrong, explain the mismatch and fix it.
5. Tighten verbose content into short, imperative instructions without changing intent.
6. Find and fix common mistakes, including unsupported frontmatter keys, mixed responsibilities, invalid prompt structure, and non-portable source-tree links.
7. Report what you changed and why, then suggest any remaining optional concision improvements.
