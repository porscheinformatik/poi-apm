---
description: Keep .apm files concise, valid, and portable.
---

1. If the user has not passed or selected a file, ask for the file.
2. Load the `author-apm` skill before editing any `.apm` file.
3. Use the matching instruction file for the target file type:
   - `apm-instructions.instructions.md` for `.apm/instructions/*.instructions.md`
   - `apm-agents.instructions.md` for `.apm/agents/*.agent.md`
   - `apm-prompts.instructions.md` for `.apm/prompts/*.prompt.md`
   - `apm-skills.instructions.md` for `.apm/skills/**/SKILL.md`
4. Check layout and filename conventions first. If the structure is wrong, explain the mismatch and ask the user to fix it.
5. Tighten verbose content into short, imperative instructions without changing intent.
   - Keep the prompt concise, valid, and portable across targets.
   - Preserve all information and behavior.
   - Keep the outcome the same, but make the prompt shorter and more portable.
   - Move optional skill content into files under the skill directory. Ask before creating files and explain what moved.
   - Leave content unchanged if it is already short, imperative, concise, valid, and portable.
6. Fix common mistakes: unsupported frontmatter keys, mixed responsibilities, invalid prompt structure, non-portable source-tree links, and skill-local samples or references that should be improved too. Ask for confirmation before larger changes.
7. Report what changed and why, then suggest any optional further concision improvements.
8. If issues are only minor, ask whether to change them or skip them.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.