---
name: apm-authoring
description: Use when creating, modifying, reviewing, or optimizing APM skills, prompts, instructions, agents, hooks, or producer-side package configuration. Focus on primitive selection, concise content, and cross-target authoring correctness.
---

# APM Authoring

Author source primitives under `.apm/` and producer configuration in `apm.yml`.
Use the `apm-usage` skill for CLI syntax, installation, dependencies,
authentication, governance, troubleshooting, and general package-layout guidance;
do not duplicate those references here.

## Workflow

1. Identify the owning source primitive and intended consumer targets. Inspect
   installed files for evidence, but do not hand-edit generated output.
2. Read the matching `apm-skills`, `apm-prompts`, `apm-instructions`,
   `apm-agents`, or `apm-yml` instruction before editing.
3. Choose one primitive per purpose. Split file policy from personas and
   explicit commands from runtime-discovered guidance.
4. Apply the authoring and portability checks below; keep the content concise
   and reference other primitives by name plus type hint, not source paths.
5. Validate the changed primitive, inspect its installed representation, and
   report unsupported target behavior rather than assuming equivalent execution.

LOAD references/authoring.md

## Related Workflows

- Use the `apm-skill`, `apm-prompt`, `apm-instructions`, or `apm-agent` prompt
  to create or update one primitive.
- Use the `review-apm` or `optimize-apm` prompt for existing package content.
- Use the `apm-summary` prompt to refresh the package inventory.