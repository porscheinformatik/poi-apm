---
description: Create or update an APM summary document from .apm contents.
---

1. Use APM_SUMMARY.md at the project root as the only summary target.
2. If APM_SUMMARY.md is missing, create it with this structure:

   # APM Summary

   ## Agents

   ## Instructions

   ## Prompts

   ## Skills

   ## Dependencies

3. Load the author-apm skill and the apm-prompts instruction before editing.
4. Determine scope from user input.
5. If the user specifies a type, directory, or file, scan and update only matching local items. Leave other APM_SUMMARY.md content intact.
6. If no scope is specified, scan all local APM source files: .apm/agents/_.agent.md, .apm/instructions/_.instructions.md, .apm/prompts/\*.prompt.md, and .apm/skills/\*\*/SKILL.md.
7. Skip .apm/AGENTS.md and generated aggregate files.
8. Read apm.yml and collect declared dependencies.
9. Include every declared dependency in the summary:
   - If apm_modules/<dependency>/APM_SUMMARY.md exists, use it as the source of truth.
   - Otherwise, scan that dependency's .apm content directly.
10. Build one complete internal todo list before writing. Include all in-scope local items and all dependency items. Do not omit any item.
11. Write five sections: Agents, Instructions, Prompts, Skills, Dependencies.
12. Do not add nested scope groupings inside those sections.
13. For each discovered item, add a headline from the full filename-derived name. Do not drop name parts. Example: apm-skill.prompt.md -> APM Skill Prompt.
14. Sort items alphabetically by headline name within each category section.
15. Format each section using these rules:
    - Agents: bullets for **Filename:** and **Command:** (#<command-name>), then one plain paragraph.
    - Instructions: bullets for **Filename:** and **Apply To:**, then one plain paragraph.
    - Prompts: bullets for **Filename:** and **Command:** (/<command-name>). Add **Inputs:** only when frontmatter inputs exist. Then add one short plain paragraph combining frontmatter description with key body steps.
    - Skills: bullets for **Filename:** and **When:**, then two plain paragraphs: description first, key body summary second.
16. In every **Filename:** field, include the relative path from the repository root (for example, `.apm/prompts/apm-skill.prompt.md`), not only the basename.
17. Insert one blank line between bullet metadata and paragraph text.
18. Write user-facing descriptions such as: "This instruction is used to...", "This prompt creates...", or "This skill is used when...".
19. Keep bullet labels bold and ending with a colon.
20. In Dependencies entries, use **Dependency:** instead of **Filename:**.
21. Sort dependency entries alphabetically by dependency name.
22. Keep output concise, imperative, deterministic, and structurally valid.
23. Keep existing content in APM_SUMMARY.md unless it is outdated or incorrect. Update only what is necessary. Remove items that do not exist anymore.
24. Keep any additional item information already present in APM_SUMMARY.md (for example, install notes).
25. Before finalizing, run a completeness gate: if apm.yml has dependencies, the Dependencies section must include each declared dependency and imported dependency items. If anything is missing, rescan dependency sources and regenerate.
26. Report what changed and why, then suggest optional concision improvements.
27. Verify every item includes a headline.
28. Verify that there are no duplicate items.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.
