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
8. For each discovered file, create a headline from the full item name extracted from the filename and do not skip name parts (for example, create-apm-prompt.prompt.md becomes Create APM Prompt).
9. Under each item headline, include bullet points for **Filename:**, **When:**, **Includes:**, and **Expected Result:** (or **Expected Outcome:** for skills).
10. Keep all bullet label lines with a colon in bold.
11. Keep wording concise, imperative where applicable, and deterministic, and fix invalid structure before finishing.
12. Report what changed and why, then suggest optional concision improvements.
