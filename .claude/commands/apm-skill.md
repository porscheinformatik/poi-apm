---
description: Create or update a skill from documentation and/or code samples
---

1. If the user provides URLs assume they are documentation.
2. If the user provides a local path assume it is a code sample.
3. If the user asks to update and no target skill file is selected or provided, ask where the existing skill file is.
4. If the skill extends an existing skill, don't add duplicate instructions, but instead reference the existing skill and only add the new instructions.
5. If the target skill file exists, update it in place; otherwise create a new skill in the .apm/skills/ directory.
6. Follow the instructions in .apm/instructions/apm-skills.instructions.md to create or update the skill.
7. Keep the skill short, imperative, and scoped to the matching glob.
8. Make sure the description uses trigger wording such as Use when or Apply when.
9. Check the result against .apm/instructions/apm-skills.instructions.md and fix any layout or frontmatter issues.