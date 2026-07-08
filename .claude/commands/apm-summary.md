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

   ## MCPs

   ## Dependencies

3. Load the author-apm skill and the apm-prompts instruction before editing.
4. Determine scope from user input.
5. If the user specifies a type, directory, or file, scan and update only matching local items. Leave other APM_SUMMARY.md content intact.
6. If no scope is specified, scan all local APM source files: `.apm/agents/*.agent.md`, `.apm/instructions/*.instructions.md`, `.apm/prompts/*.prompt.md`, `.apm/skills/**/SKILL.md`, and `.apm/mcp/*.mcp.json`.
7. Skip .apm/AGENTS.md and generated aggregate files.
8. Read apm.yml and collect declared dependencies.
9. Include every declared dependency in the summary:
   - If `apm_modules/<dependency>/APM_SUMMARY.md` exists, use it as the source of truth.
   - Otherwise, scan that dependency's .apm content directly.
10. Build one complete internal todo list before writing. Include all in-scope local items and all dependency items. Do not omit any item.
11. Write six sections: Agents, Instructions, Prompts, Skills, MCPs, Dependencies.
12. Merge dependency items into their matching type sections (Agents, Instructions, Prompts, Skills, MCPs). Do not move dependency item descriptions into `Dependencies`.
13. Use the `Dependencies` section only for package-level dependency declarations from `apm.yml` (`dependencies.apm` and `dependencies.mcp`).
14. Do not add nested scope groupings inside those sections.
15. For each discovered item, add a headline from the full filename-derived name. Do not drop name parts. Example: `apm-skill.prompt.md` -> APM Skill Prompt.
16. Sort items alphabetically by headline name within each category section.
17. Format each section using these rules:
    - Agents: bullets for **Filename:** and **Command:** (`#<command-name>`), then one plain paragraph.
    - Instructions: bullets for **Filename:** and **Apply To:**, then one plain paragraph.
    - Prompts: bullets for **Filename:** and **Command:** (`/<command-name>`). Add **Inputs:** only when frontmatter inputs exist. Then add one short plain paragraph combining frontmatter description with key body steps.
    - Skills: bullets for **Filename:** and **When:**, then two plain paragraphs: description first, key body summary second.
    - MCPs: bullets for **Filename:** and **MCP:** (server name), then one plain paragraph describing purpose and usage scope.
18. For dependency-origin items in Agents/Instructions/Prompts/Skills/MCPs, add a **Dependency:** bullet with the dependency name and keep the item in that same section.
19. The only marker that an item comes from a dependency is the **Dependency:** bullet. Do not create separate dependency-only subsections for item descriptions.
20. In every metadata value that is a technical identifier, use backticks. This includes `Filename`, `Command`, `Apply To`, `Dependency`, `MCP`, dependency names, and command names.
21. In every **Filename:** field, include the relative path from the package root (for example, `.apm/prompts/apm-skill.prompt.md`), not only the basename.
22. Insert one blank line between bullet metadata and paragraph text.
23. Write user-facing descriptions such as: "This instruction is used to...", "This prompt creates...", or "This skill is used when...".
24. Keep bullet labels bold and ending with a colon.
25. In `Dependencies`, include all declared package dependencies from `apm.yml` and all resolved dependency package names used for merged items.
26. Sort dependency entries alphabetically by dependency name.
27. Keep output concise, imperative, deterministic, and structurally valid.
28. Keep existing content in APM_SUMMARY.md unless it is outdated or incorrect. Update only what is necessary. Remove items that do not exist anymore.
29. Keep any additional item information already present in APM_SUMMARY.md (for example, install notes).
30. Before finalizing, run a completeness gate:
    - Every declared dependency in `apm.yml` appears in `Dependencies`.
    - Dependency items are merged into their native sections and include **Dependency:**.
    - `MCPs` includes all local and dependency MCP servers.
    - If anything is missing, rescan dependency sources and regenerate.
31. Report what changed and why, then suggest optional concision improvements.
32. Verify every item includes a headline.
33. Verify that there are no duplicate items.

> **Tip:** When this prompt needs to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.