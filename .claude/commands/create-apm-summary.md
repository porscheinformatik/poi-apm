---
description: Create or refresh an APM summary document from .apm contents.
---

1. Use APM_SUMMARY.md in the project root as the only summary target.
2. If APM_SUMMARY.md is missing, create it with this structure:

   # APM Summary

   ## Agents

   ## Instructions

   ## Prompts

   ## Skills

3. Load .apm/skills/author-apm/SKILL.md and .apm/instructions/apm-prompts.instructions.md before editing.
4. Scan .apm/agents/_.agent.md, .apm/instructions/_.instructions.md, .apm/prompts/\*.prompt.md, and .apm/skills/\*\*/SKILL.md.
5. Skip .apm/AGENTS.md and generated aggregate files.
6. Write exactly four sections: Agents, Instructions, Prompts, Skills.
7. Do not add nested scope groupings inside those sections.
8. For each discovered item, add a headline from the full filename-derived name. Do not drop name parts. Example: create-apm-skill.prompt.md -> Create APM Skill Prompt.
9. Format each section using these rules:
   - Agents: bullets for **Filename:** and **Command:** (# plus the command name), then one plain paragraph.
   - Instructions: bullets for **Filename:** and **Apply To:**, then one plain paragraph.
   - Prompts: bullets for **Filename:** and **Command:** (/ plus the command name). Add **Inputs:** only when frontmatter inputs exist. Then add one short plain paragraph combining frontmatter description with key body steps.
   - Skills: bullets for **Filename:** and **When:**, then two plain paragraphs: description first, key body summary second.
10. Insert one blank line between bullet metadata and paragraph text.
11. Write user-facing descriptions such as: "This instruction is used to...", "This prompt creates...", or "This skill is used when...".
12. Keep bullet labels bold and ending with a colon.
13. Check .apm.yml for dependencies. If there is any dependency, add a "Dependencies" section to the end of the document listing each dependency.
14. If dependencies exist:
    - Scan apm_modules and include dependency items in the summary.
    - Use **Dependency:** instead of **Filename:** for dependency entries.
    - If a dependency includes APM_SUMMARY.md, use it directly instead of rescanning all dependency files.
15. Keep output concise, imperative, deterministic, and structurally valid.
16. Report what changed and why, then suggest optional concision improvements.
17. Verify every item includes a headline.