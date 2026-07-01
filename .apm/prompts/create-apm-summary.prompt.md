---
description: Create or refresh an APM summary document from .apm contents.
---

1. Use APM_SUMMARY.md in the project root as the only target summary file.
2. If APM_SUMMARY.md is missing, create it with this base structure:

   # APM Summary

   ## Agents

   ## Instructions

   ## Prompts

   ## Skills

3. Load the author-apm skill and .apm/instructions/apm-prompts.instructions.md before editing.
4. Scan .apm/agents/_.agent.md, .apm/instructions/_.instructions.md, .apm/prompts/\*.prompt.md, and .apm/skills/\*\*/SKILL.md.
5. Skip .apm/AGENTS.md and other generated aggregate files.
6. Write output in exactly four sections: Agents, Instructions, Prompts, Skills.
7. Do not add extra scope groupings inside those sections.
8. For each discovered file, create a headline from the full item name extracted from the filename and do not skip name parts (for example, create-apm-skill.prompt.md becomes Create APM Skill Prompt).
9. Format each section with these item rules:
   - Agents: bullet points for **Filename:**, **Command:** (# and the name), then one regular paragraph description.
   - Instructions: bullet points for **Filename:** and **Apply To:**, then one regular paragraph description.
   - Prompts: bullet point for **Filename:**, **Command:** (/ and the name). Add **Inputs:** only when inputs exist in frontmatter; omit **Inputs:** when there are none. Then add one short regular paragraph using the frontmatter description plus important facts from the body steps.
   - Skills: bullet points for **Filename:** and **When:**, then two regular paragraphs: first the description, then a short summary from important body content.
10. Insert one blank line between bullet points and paragraph text.
11. The description should describe to the user what the item does, use prases like "This instruction is used to...", "This prompt creates ..." or "This skill is used when ...".
12. Keep all bullet label lines with a colon in bold.
13. Keep wording concise, imperative where applicable, and deterministic, and fix invalid structure before finishing.
14. Report what changed and why, then suggest optional concision improvements.
