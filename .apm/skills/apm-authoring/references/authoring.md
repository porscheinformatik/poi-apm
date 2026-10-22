# Primitive Authoring Checks

Apply these producer-specific checks alongside the matching authoring
instruction. Consult the `apm-usage` skill for general CLI and manifest syntax.

## Choose the Surface

| Intent | Source | Consumer contract |
| --- | --- | --- |
| Runtime-discovered task guidance | `.apm/skills/<name>/SKILL.md` | Description selects the workflow; bundled resources travel with it |
| Explicit single-purpose workflow | `.apm/prompts/<name>.prompt.md` | Filename defines the prompt or slash-command name |
| File-pattern policy | `.apm/instructions/<name>.instructions.md` | `applyTo` controls scope where the target supports it |
| Named specialist persona | `.apm/agents/<name>.agent.md` | Role, boundaries, expected inputs and outputs |
| Runtime callback | `.apm/hooks/<name>.json` | Native event and handler semantics must be tested per harness |
| Consumer tool server | `dependencies.mcp` in `apm.yml` | Manifest declaration, not a file under `.apm/mcp/` |

- Commands share prompt sources; there is no `.apm/commands/` directory.
- Prefer skills when the workflow must reach targets without prompts or agents.
- Keep consumer-facing MCP servers in `dependencies.mcp`; author-only mocks and
  debug bridges belong in `devDependencies.mcp` and must not ship to consumers.

## Content and Metadata

- Encode Markdown as UTF-8. If frontmatter is present, put its opening fence
  on line 1; otherwise APM treats the document as body content. Malformed
  instruction frontmatter blocks deployment.
- Give each primitive one purpose. Do not repeat workspace-wide policy inside
  a persona or reproduce the CLI manual in a task guide.
- For skills, keep `name` equal to the directory name and write an intent-first
  `description` starting with `Use when` or `Apply when` (at most 1024 characters).
  APM derives identity from the directory, so renaming only frontmatter is not
  a complete rename.
- Keep `SKILL.md` under 500 lines and roughly 5000 tokens. Put optional detail
  one level down in `references/` with explicit `LOAD references/<file>` lines.
  Ship actual resources rather than symlinks, which skill deployment filters out.
- For prompts, keep authoritative metadata to `description`, `input`,
  `allowed-tools`, `model`, and `argument-hint`. Use `${input:name}` in the body;
  input names must match `[A-Za-z][\w-]{0,63}`. Extra metadata can be dropped with
  diagnostics on transformed targets.
- For instructions, use explicit `applyTo` for scoped policy. Missing scope
  folds the rule into root context. Prefer a comma-separated glob string;
  commas inside brace alternation are not pattern separators.
- For agents, open with role and scope, define boundaries and expected artifacts,
  and stay under 300 lines. Do not name an agent `default` or `start`.
- Keep links within a skill bundle relative to the bundle. Reference other
  primitives by name plus type hint so deployment paths do not leak into content.

## Target-Specific Decisions

- Codex receives no prompts or slash commands. Provide a skill when that
  workflow must reach Codex.
- Windsurf and Gemini receive no agent files. Use skills for those personas.
- Kiro now receives agents, but only preserves `description`, `model`, and
  `tools`. Unsupported tool capability tags prevent deployment; do not assume
  an OpenCode-style tool mapping is portable to Kiro.
- Codex agents preserve supplied string `model` and `model_reasoning_effort`
  values, but not tool restrictions. If restricted tool access is required,
  do not use the generated Codex agent as an equivalent security boundary.
- OpenCode agents require a boolean tool mapping and a supported theme color
  or hex color. Installation warnings do not mean its loader accepts the file.
- Agent `user-invocable: false` (or `visibility: internal`) expresses picker
  intent only where the receiving harness supports it; it is not access control.
- Copilot ignores prompt `allowed-tools`; prompt `model` is not universal.
- Hook configuration compatibility is not execution parity. Use documented
  lifecycle aliases and test the actual target; unknown names may survive
  installation without ever firing.
- Use simple hook filenames and manifest `targets:` for package reach, not
  deprecated filename-based routing. Package selectors only narrow consumer
  authorization; they never activate additional targets.
- Use quoted `${PLUGIN_ROOT}` paths for bundled hook scripts. For Copilot or
  VS Code ES modules, use `.mjs`: hook bundles omit JSON assets and the Node
  `package.json` sidecar on these targets.
- Choose either native Cursor hooks or Claude-imported hooks per dependency.
  Overlapping routes can fail installation or duplicate execution.
- Document self-defined MCP servers and their trust requirements. Transitive
  self-defined servers are skipped unless the consumer explicitly trusts them.

## Prove the Authored Result

1. Run `apm compile --validate` for frontmatter and structural checks.
2. Run `apm audit --file <changed-file>` for changed Markdown, including bundled
   references. Compilation does not re-scan edited content for hidden Unicode.
3. Run `apm install --dry-run --target <target>` for routing, then inspect an
   actual installation when transformed output matters. Compile alone does not
   redeploy skills, prompts, agents, hooks, or MCP configuration.
4. For hooks, inspect the installed native configuration and execute a focused
   harness check: install dry-run does not render hook previews.
5. If a prompt is script-wired, run `apm preview <script>`. For shipping bundled
   resources, inspect `apm pack --dry-run --verbose` for missing files.
6. For a rename, verify the new directory and metadata agree, update callers,
   and confirm the old deployed identity is retired without deleting user files.

## Upstream References

Reviewed against the producer documentation on 2026-10-22:

- [Author primitives](https://microsoft.github.io/apm/producer/author-primitives/)
- [Skills](https://microsoft.github.io/apm/producer/author-primitives/skills/)
- [Prompts](https://microsoft.github.io/apm/producer/author-primitives/prompts/)
- [Instructions and agents](https://microsoft.github.io/apm/producer/author-primitives/instructions-and-agents/)
- [Hooks and commands](https://microsoft.github.io/apm/producer/author-primitives/hooks-and-commands/)
- [MCP as a primitive](https://microsoft.github.io/apm/producer/author-primitives/mcp-as-primitive/)

Check the current [targets matrix](https://microsoft.github.io/apm/reference/targets-matrix/)
when adding a harness rather than copying a static routing table into the skill.