# Authoring APM Primitives

Use this section when creating, modifying, reviewing, or optimizing APM packages so the model picks the right primitive, writes it in the correct `.apm/` location, and validates what consumers will receive.

Use this guidance to author source primitives under `.apm/` and `apm.yml`, not long-form docs or generated output.

## Source of truth

- Treat `.apm/` as the only editable source for primitives.
- Treat generated files such as `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/instructions/`, `.claude/rules/`, and `.agents/skills/` as inspection surfaces. Read them to verify output, then fix the owning `.apm/` source.
- If the request starts from a generated file, identify the owning primitive first, then edit the source primitive instead of hand-editing compiled output.
- Reference related primitives by name plus type hint, not by `.apm/...` path. This keeps the content portable across targets.
- Prefer short, operational instructions over narrative explanation.

## Choose the primitive type

- **Skill**: Use for reusable task guidance the runtime should discover from its description during a conversation.
- **Prompt**: Use for an explicit, single-purpose command the user invokes on demand.
- **Instruction**: Use for always-on policy that should attach to matching files through `applyTo`.
- **Agent**: Use for an explicitly invoked persona with scoped responsibilities, model choice, or tool limits.
- **Hook**: Use for runtime events such as pre-commit or tool-use interception.
- **MCP primitive**: Use when the package needs to declare a tool server consumers can wire into their harness.

### Primitive selection rules

- Commands are authored as prompts under `.apm/prompts/`; there is no `.apm/commands/` directory.
- If one request mixes policy and persona, split it into separate primitives instead of forcing both into one file.
- If a persona must reach Windsurf, Kiro, or Gemini, prefer a skill. Those targets do not deploy `.agent.md` files.
- If Codex coverage matters for an on-demand workflow, do not rely on a prompt alone. Pair it with a skill because Codex has no prompts primitive.

## Create in the right location

Use these canonical source paths when a file does not exist yet:

```text
.apm/
  skills/
    <skill-name>/
      SKILL.md
      references/
      scripts/
      assets/
      examples/
  prompts/
    <prompt-name>.prompt.md
  instructions/
    <instruction-name>.instructions.md
  agents/
    <agent-name>.agent.md
  hooks/
    <hook-name>.json
  mcp/
    <server-name>.mcp.json
```

- Create the directory first for skills; every other primitive is a file in its type directory.
- Skill names must match the parent directory and use lowercase letters, numbers, and hyphens only.
- Prompt filenames define the command name on every target. Keep one workflow per file.
- Instruction filenames end in `.instructions.md`; the basename becomes the deployed rule stem.
- Agent filenames end in `.agent.md`. Do not name an agent `default` or `start`.
- Root-level prompt files are only backward-compatible legacy discovery; prefer `.apm/prompts/`.

## Authoring contract

- Read the matching authoring rule before editing a primitive source:
  - `apm-skills` instruction for `.apm/skills/**/SKILL.md`
  - `apm-prompts` instruction for `.apm/prompts/*.prompt.md`
  - `apm-instructions` instruction for `.apm/instructions/*.instructions.md`
  - `apm-agents` instruction for `.apm/agents/*.agent.md`
- Keep one primary purpose per primitive. Split mixed concerns.
- Keep bodies concise enough for model context. Move long-tail material into `references/` and load it with `LOAD references/<file>`.
- Use source-relative Markdown links only when the target file already exists inside the package. APM rewrites eligible links for prompts, instructions, agents, and commands at install time.
- Links inside a single skill bundle usually do not need rewriting because the whole skill directory is copied as-is.

## Minimum frontmatter by primitive

- **Skill**: `name`, `description`. `name` must match the directory; `description` should start with `Use when` or `Apply when` and lead with user intent.
- **Prompt**: `description`; optionally `input`, `allowed-tools`, `model`, `argument-hint`. Only these preserved keys should be treated as authoritative.
- **Instruction**: `description` and usually `applyTo`. Missing `applyTo` makes the rule unconditional and folds it into compiled root context files.
- **Agent**: `description` required; `name` recommended; `model`, `tools`, `color`, and `handoffs` optional. `tools` must stay a boolean mapping for OpenCode portability.

## Edit and optimize workflow

- Start from the source primitive, not from deployed output.
- When optimizing an existing package, inspect generated `AGENTS.md`, `CLAUDE.md`, or deployed target files to detect duplication, dropped scoping, missing reach, or portability regressions.
- Use generated output to answer questions like:
  - Did an instruction stay scoped, or did missing `applyTo` fold it into root context?
  - Did a target receive nothing because the primitive type does not deploy there?
  - Did the installed wording stay concise after compilation and target transforms?
- When the generated output is wrong, change the source primitive and re-run the narrow validation loop.

## Validation loop

- For instruction edits, run `./apm.sh compile --validate` first in this repo. It is the quickest local sanity check.
- Then run `apm compile --dry-run --target <target>` to confirm target selection, deduplication, or output placement.
- Use `apm compile --watch` only for tight instruction-authoring iteration.
- Remember that `apm compile` only handles instructions and root-context generation. It does not redeploy skills, prompts, agents, hooks, or MCP primitives.
- For skills, prompts, agents, hooks, and MCP changes, run `apm install --dry-run --target <target>` to preview routing, then `apm install --target <target>` if you need to inspect deployed bytes.
- If a prompt is wired through `scripts:` in `apm.yml`, use `apm preview <script>` to inspect the rewritten command line.
- After hand edits, run `apm audit --file <path>` on the changed primitive. Before publishing, run `apm audit` for hidden-Unicode and drift checks.
- Use `apm view <package>` and `apm outdated` when validating the package, not just one primitive.

## Review checklist

- [ ] The primitive type matches the user intent.
- [ ] The file lives in the correct `.apm/` location and follows the correct naming suffix.
- [ ] Required frontmatter is present and portable for the intended targets.
- [ ] The body is concise, operational, and split from unrelated concerns.
- [ ] Generated files were used for verification only, not as the edited source.
- [ ] The chosen validation command matches the primitive type: `compile` for instructions, `install` for deployable primitives, `preview` for script-wrapped prompts, `audit` before shipping.

## Tip

When authoring primitives that need to ask questions to collect required values or clarifications, use the `askQuestions` MCP to ensure structured, permission-based question collection.
