---
paths:
  - ".apm/skills/**/SKILL.md"
---

Use this file when authoring APM skill files.

## What a skill is

- A skill is runtime-invoked guidance selected from its description.
- Use skills for reusable task playbooks and domain workflows.
- Keep one primary purpose per skill to improve runtime selection quality.
- Keep SKILL.md focused and move deep context to supporting files.

## Skill layout rules

- Store each skill in its own directory under .apm/skills/<name>/.
- Require SKILL.md.
- Optional folders: scripts/, references/, assets/, examples/.
- The directory name is the skill identity.

## Frontmatter rules

- Supported core keys: name, description.
- name must match the parent directory name.
- name must use lowercase letters, numbers, and hyphens.
- name must stay within 1 to 64 characters for cross-runtime compatibility.
- Avoid leading, trailing, or repeated hyphens.
- description must be non-empty and stay within 1024 characters.

Description guidance:

- Start with an imperative trigger such as Use when or Apply when.
- Lead with user intent and trigger conditions.
- Describe situations, not slash commands.
- Keep descriptions concise and specific.
- Put disambiguating keywords in the first sentence to reduce collisions.

## Body guidance

- Keep SKILL.md short and operational.
- Keep SKILL.md under 500 lines (and roughly under 5000 tokens) when possible.
- Prefer direct steps and clear boundaries.
- Put long references in references/\*.md.
- Use explicit LOAD references/<file> lines for optional deep context.
- Keep references one level deep from SKILL.md.
- Add a brief table of contents at the top of longer reference files.
- Use forward-slash paths in all examples and references.

## Workflow and quality guidance

- Use imperative, step-based instructions for multi-step tasks.
- Add validation loops for fragile tasks: run check, fix, re-run.
- Match strictness to risk: use exact commands for dangerous operations and flexible guidance for exploratory tasks.
- Prefer deterministic scripts for repetitive or error-prone operations.
- Be explicit whether a script should be executed or read as reference.
- Include concise good and bad examples when output format quality matters.

## Conversion hints (Claude/Copilot -> APM)

- Keep only portable metadata in frontmatter. Treat extra keys as target-specific and optional unless APM or target docs explicitly guarantee support.
- Convert command-centric triggers into situation-centric triggers.
- Replace vague descriptions with intent plus context keywords in the first sentence.
- Split oversized SKILL.md files into references/ and link with explicit LOAD lines.
- Flatten nested reference chains so SKILL.md links directly to each important reference file.
- Replace hardcoded workspace paths with generic, reusable instructions.
- Move long narrative explanations into references/ and keep SKILL.md operational.
- Convert ambiguous tool mentions into concrete tool names and expected outputs.
- Keep target-specific runtime assumptions behind optional notes.

APM compatibility notes:

- APM is a packaging and deployment layer, not a full runtime-behavior shim.
- Do not rely on a single harness-specific feature for correctness.
- Validate converted skills with APM CLI checks before publishing.

## Target behavior summary

- Claude deploys to .claude/skills/<name>/SKILL.md.
- Kiro deploys to .kiro/skills/<name>/SKILL.md.
- Copilot, Cursor, Codex, Gemini, OpenCode, and Windsurf deploy to .agents/skills/<name>/SKILL.md.
- Skill directories are copied with bundled resources.

## Common mistakes

- Vague descriptions that collide with other skills.
- Frontmatter name not matching directory name.
- Oversized SKILL.md files that reduce runtime context quality.
- Forgetting to separate optional deep-dive content into references/.
- Deeply nested references that hide critical instructions from initial skill navigation.
- Using invalid or unsupported target names in apm.yml.
- Referencing other agents, instructions, prompts, or skills by .apm/... path instead of by name plus type hint.

## Validation checklist

- Run apm compile --validate.
- Run apm install --dry-run --target <target>.
- Run apm audit --file .apm/skills/<name>/SKILL.md.
