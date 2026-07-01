---
description: Create a single .instructions.md file from a set of source files.
---

1. Ask the user to provide one or more files if none are selected or passed.
2. Confirm the files belong to one domain and one wildcard pattern. If they do not, ask for a narrower set.
3. Read the files and extract only the rules that apply across all of them.
4. Create one new instructions file under .apm/instructions/.
5. Keep the instructions short, imperative, and scoped to the matching glob.
6. Check the result against .apm/instructions/apm-instructions.instructions.md and fix any layout or frontmatter issues.
7. Summarize what you included, what you excluded, and why.
