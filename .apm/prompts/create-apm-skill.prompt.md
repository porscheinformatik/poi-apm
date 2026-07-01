---
description: Create a new skill from documentation and/or code samples
---

1. If the user provides URLs assume they are documentation.
2. If the user provides a local path assume it is a code sample.
3. If the skill extends an existing skill, don't add duplicate instructions, but instead reference the existing skill and only add the new instructions.
4. Use the documentation to create a new skill in the .apm/skills/ directory.
5. Follow the instructions in .apm/instructions/apm-skill.instructions.md to create the skill.
6. Keep the skill short, imperative, and scoped to the matching glob.
7. Check the result against .apm/instructions/apm-skill.instructions.md and fix any layout or frontmatter issues.
