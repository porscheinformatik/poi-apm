---
argument-hint: <source_mode> <task_instructions> <source_files> <target_instructions>
  <search_similar> <similar_include_pattern>
arguments:
- source_mode
- task_instructions
- source_files
- target_instructions
- search_similar
- similar_include_pattern
description: Create or update a single .instructions.md file from a set of source
  files.
---

1. Determine the source mode first:
   - If $source_mode is instructions, use $task_instructions as the primary source.
   - If $source_mode is chat or omitted, default to converting the current chat request into reusable instructions.
   - If files are provided in $source_files, treat those files as the primary source of truth.
   - If both chat context and $task_instructions are present and no explicit source mode is set, ask which source is primary.
2. If no primary source files are provided or selected and the task needs file-derived rules, use askQuestions to request one or more source files.
3. Resolve the target instructions path:
   - Prefer $target_instructions when provided.
   - Otherwise infer from user intent and ask for confirmation when ambiguous.
   - Enforce .apm/instructions/<name>.instructions.md.
4. For updates:
   - If the target file exists in .apm/instructions/, update it in place.
   - If it does not exist locally, search apm_modules/\*\* for the same filename and copy it into .apm/instructions/ before editing.
   - If it is not found, ask whether to create a new local instructions file.
5. Validate source scope before authoring:
   - Confirm primary files belong to one domain and can share one applyTo pattern.
   - If they span unrelated domains, use askQuestions to request a narrower set.
6. Read primary files and extract only rules that consistently apply across them.
7. If $search_similar is true or omitted, search the project for similar files, then use them as secondary evidence to strengthen or refine shared rules.
8. Handle rule conflicts conservatively:
   - Compare extracted rules against existing instructions conventions.
   - If similar files conflict with current rules, treat them as potentially outdated examples.
   - When uncertain, ask the user whether to include or exclude those conflicting rules.
9. Write or update the instructions file using APM conventions:
   - Keep one intent per file, with short imperative steps.
   - Keep frontmatter valid; description should usually start with "Rules for" or "Guidelines for" and name a specific file set.
   - Set applyTo to the validated wildcard scope.
10. Validate against .apm/instructions/apm-instructions.instructions.md and fix frontmatter, structure, or style issues.
11. Summarize what changed, why, and whether the file was created, updated in place, or copied from apm_modules then updated. Include what was excluded and any user-decided conflict resolutions.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.