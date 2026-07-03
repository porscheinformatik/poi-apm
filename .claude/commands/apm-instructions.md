---
description: Create or update a single .instructions.md file from a set of source
  files.
---

1. Ask the user to provide one or more files if none are selected or passed.
2. If the user asks to update and no target instructions file is selected or provided, ask where the target file is.
3. Confirm the files belong to one domain and one wildcard pattern. If they do not, ask for a narrower set.
4. Read the files and extract only the rules that apply across all of them.
5. If the target instructions file exists, update it in place; otherwise create one new instructions file under .apm/instructions/.
6. Keep the instructions short, imperative, and scoped to the matching glob.
7. Check the result against .apm/instructions/apm-instructions.instructions.md and fix any layout or frontmatter issues.
8. Summarize what you included, what you excluded, and why.